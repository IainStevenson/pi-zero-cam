#!/bin/bash

# ==========================
# STREAM SETTINGS
# ==========================
WIDTH=1280
HEIGHT=720
FPS=25
BITRATE=2000000

# ==========================
# DEFAULT PROFILE
# ==========================
PROFILE="day-min"

# ==========================
# PROFILE DEFINITIONS
# ==========================

set_profile() {
    case "$1" in
        day-max)
            BRIGHTNESS=0.1
            CONTRAST=1.2
            EXPOSURE=normal
            ;;
        day-min)
            BRIGHTNESS=0.0
            CONTRAST=1.0
            EXPOSURE=normal
            ;;
        night-max)
            BRIGHTNESS=0.2
            CONTRAST=1.3
            EXPOSURE=short
            ;;
        night-min)
            BRIGHTNESS=0.3
            CONTRAST=1.5
            EXPOSURE=long
            ;;
        *)
            echo "Unknown profile: $1"
            exit 1
            ;;
    esac
}

set_profile "$PROFILE"