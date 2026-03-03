#Pi Zero 2 W Camera System – Requirements

I have a PI zero 2 W running the Raspberry Pi OS 64bit. It has a NOIR camera attached and successfully joins my WIFI network as is.

The camera has been tested and works, using rpicam-vid using the following commands at the ssh terminal displaying direct to the attached HDMI display.

```
export DISPLAY=:0
nohup rpicam-vid -t 0 --fullscreen --exposure long > /home/pi/camera.log 2>&1 &

```

I need to be able to run this headless, or with display, and its primary use is via an HTML client remotely viewing what the camera sees, and remotely adjusting parameters to change the camera manually to improve under varying light conditions.


1. Hardware & OS

* Raspberry Pi Zero 2 W with NOIR camera attached via CSI
* Raspberry Pi OS 64-bit
* Optional local display (initially attached for setup and experimentation, may be removed later, or remain permanently)
* Headless operation must work correctly whenever display is absent

2. Local Display Behavior

* If a display is present at boot, automatically start a fullscreen camera viewer on the local display
* If no display is present, the local viewer does not start
* Local viewer is purely optional; system must detect display dynamically
* Local display may be used:
 * During setup and experimentation
 * As a checkup tool
 * Potentially as a permanent feature

3. Camera Capture & Streaming

* Single libcamera-vid process for capture to minimize CPU load
* Camera feed streamed via MediaMTX (RTSP) for remote viewing
* Streaming continues regardless of whether a display is attached
* System must support headless operation reliably

4. Parameter Adjustment & Profiles

* Adjustable brightness, contrast, exposure via HTTP URL on port 80
 * Example: http://<pi-ip>/?brightness=80&contrast=50&exposure=night
 * Missing parameters retain current values
* Multiple lighting profiles can be defined (e.g., day-max, day-min, night-max, night-min)
* Profiles allow the camera to automatically defend itself against sudden light changes (e.g., barn lights at night)
* Switching profiles or parameters restarts the camera stream automatically, briefly interrupting the feed
* Manual adjustments via HTTP are possible, but the system should also be self-defending via:
 * Optional light sensor on GPIO detecting sudden brightness jumps
 * Optional time-of-day profile switch if desired

5. Service Management & Boot

* Fully modular scripts:
 1. Setup — install required packages and dependencies
 2. Variables — define default parameters and profiles (pi-zero-cam-vars.sh)
 3. Config — create systemd service files (camera stream, conditional display, HTTP endpoint, optional light sensor)
 4. Services — enable and start all services at boot
* Services must restart automatically on failure
* Scripts must fail on first error to avoid silent misconfiguration

6. Performance & Reliability

* Minimal CPU usage: single capture process, optional display viewer only when attached
* Camera must respond immediately to sudden light changes (especially at night)
* System must continue streaming and be hands-off once configured
* Display attach/detach should be handled dynamically without requiring configuration changes

7. Optional / Future Features

* Light sensor for automatic profile switching (recommended for sudden night light events)
* Time-of-day profile switching
* Permanent local display if desired
* Security, storage, or recording is not required
* SD card wear and thermal concerns are secondary; a heatsink may be added

8. Remote client.

* Only a web browser on port 80. 
* Change of profile is via url request parameters.
* A change in any parameter value from current settings can trigger a process restart if that is all that will be possible.

✅ Summary:


* Local display is conditional and dynamic.
* Remote streaming and remote parameter adjustment are always active.
* System must be CPU-efficient, robust, and automatic across reboots.
