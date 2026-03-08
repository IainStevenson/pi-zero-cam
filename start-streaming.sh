#!/bin/bash
rpicam-vid -t 0 --width 640 --height 360 --exposure long --awb cloudy --framerate 30 --bitrate 1500000 --inline --listen -o tcp://0.0.0.0:8554