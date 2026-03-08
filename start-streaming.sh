#!/bin/bash
rpicam-vid -t 0 --width 1280 --height 720 --exposure long --awb cloudy --framerate 30 --bitrate 1500000 --inline --listen -o tcp://0.0.0.0:8554
