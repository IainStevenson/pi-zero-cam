#!/usr/bin/env python3
import http.server
import socketserver
import threading
import subprocess
import time
import os

from pi_zero_cam_vars import CAM_WIDTH, CAM_HEIGHT, CAM_FRAMERATE, CAM_PORT

MJPEG_PORT = CAM_PORT
CAM_CMD = [
    "rpicam-vid",
    "--width", str(CAM_WIDTH),
    "--height", str(CAM_HEIGHT),
    "--framerate", str(CAM_FRAMERATE),
    "-t", "0",
    "-o", "-"
]

latest_frame = None
frame_lock = threading.Lock()

def camera_thread():
    global latest_frame
    proc = subprocess.Popen(CAM_CMD, stdout=subprocess.PIPE)
    data = b""
    while True:
        chunk = proc.stdout.read(1024)
        if not chunk:
            break
        data += chunk
        while True:
            start = data.find(b"\xff\xd8")
            end = data.find(b"\xff\xd9", start+2)
            if start != -1 and end != -1:
                frame = data[start:end+2]
                with frame_lock:
                    latest_frame = frame
                data = data[end+2:]
            else:
                break
    proc.wait()

class MJPEGHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/":
            self.send_error(404)
            return
        self.send_response(200)
        self.send_header("Content-type", "multipart/x-mixed-replace; boundary=frame")
        self.end_headers()
        while True:
            with frame_lock:
                frame = latest_frame
            if frame:
                self.wfile.write(b"--frame\r\n")
                self.wfile.write(b"Content-Type: image/jpeg\r\n\r\n")
                self.wfile.write(frame)
                self.wfile.write(b"\r\n")
            time.sleep(0.03)

if __name__ == "__main__":
    t = threading.Thread(target=camera_thread, daemon=True)
    t.start()

    with socketserver.ThreadingTCPServer(("", MJPEG_PORT), MJPEGHandler) as httpd:
        print(f"Serving MJPEG at http://0.0.0.0:{MJPEG_PORT}")
        httpd.serve_forever()