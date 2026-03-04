#!/usr/bin/env python3
import os
import subprocess
import threading
import http.server
import socketserver
import time

# -----------------------------
# Import camera variables
# -----------------------------
from pi_zero_cam_vars import CAM_WIDTH, CAM_HEIGHT, CAM_FRAMERATE, CAM_PORT

# -----------------------------
# Detect local display (framebuffer)
# -----------------------------
fb_exists = os.path.exists("/dev/fb0")

if fb_exists:
    # Only run fullscreen preview if screen attached
    print("Framebuffer detected. Launching local fullscreen preview.")
    env = os.environ.copy()
    env["DISPLAY"] = ":0"
    subprocess.Popen([
        "rpicam-vid",
#        "--width", str(CAM_WIDTH),
#        "--height", str(CAM_HEIGHT),
#        "--framerate", str(CAM_FRAMERATE),
        "-t", "0",
        "--fullscreen"
    ], env=env)
    # Keep script alive so process doesn’t exit
    while True:
        time.sleep(10)

else:
    # -----------------------------
    # MJPEG server for remote browser
    # -----------------------------
    latest_frame = None
    frame_lock = threading.Lock()

    def camera_thread():
        global latest_frame
        proc = subprocess.Popen([
            "rpicam-vid",
            "--width", str(CAM_WIDTH),
            "--height", str(CAM_HEIGHT),
            "--framerate", str(CAM_FRAMERATE),
            "-t", "0",
            "--codec", "mjpeg",
            "-o", "-"
        ], stdout=subprocess.PIPE)

        data = b""
        while True:
            chunk = proc.stdout.read(1024)
            if not chunk:
                break
            data += chunk
            # Detect JPEG frames
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
            self.send_header(
                "Content-type",
                "multipart/x-mixed-replace; boundary=frame"
            )
            self.end_headers()
            while True:
                with frame_lock:
                    frame = latest_frame
                if frame:
                    self.wfile.write(b"--frame\r\n")
                    self.wfile.write(b"Content-Type: image/jpeg\r\n\r\n")
                    self.wfile.write(frame)
                    self.wfile.write(b"\r\n")
                time.sleep(0.03)  # ~30 fps

    # Start camera capture thread
    t = threading.Thread(target=camera_thread, daemon=True)
    t.start()

    # Start HTTP server for MJPEG
    with socketserver.ThreadingTCPServer(("", CAM_PORT), MJPEGHandler) as httpd:
        print(f"Serving MJPEG at http://0.0.0.0:{CAM_PORT}")
        httpd.serve_forever()