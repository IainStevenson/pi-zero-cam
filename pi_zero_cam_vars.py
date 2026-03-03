# Variables for Pi Zero Camera

# MJPEG server
CAM_WIDTH=1280
CAM_HEIGHT=720
CAM_FRAMERATE=15
CAM_PORT=8080

# Path to Python server script
CAM_PYTHON_SCRIPT="$HOME/scripts/pi-zero-cam.py"

# Profiles (manual switching for now)
PROFILE_DAY="--brightness 0 --contrast 0"
PROFILE_NIGHT="--brightness 20 --contrast 10"

# Optional local display fullscreen
FULLSCREEN_IF_PRESENT=True