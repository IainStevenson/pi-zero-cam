# PI Zero Cam

This code will setup a PI cam service on http://<pi-address?:8080 to view the camera  video feed.

If a display screen is attached via teh HDMI on boot, it will disply only on the screen for setup/aiming etc. 

Then reboot without the HDMI attached screen to setup the web served video.


## Hardware recipe

PI Zero 2 W (with or without headers)
NOIR or other PI Zero compatible camera

Assemble

## Software recipe

Burn an SSD using the RPI imaged Raspberry OS 64 Bit.

Setup with a password and SSH as a mimimum.

Load the finished SSD.

Run from your cloned repo.

```
./device-deploy.sh
```

Enter your device IP address.
Enter your password used for the pi SSD OS card. It will ask a few times.

Once completed the process will be running and depedning on an attached display, either show the camera view on teh display, or via 

http://pi-address>:8080

The display rate is set to auto for a display setup, and  1280*720@15 fps for http. 

This limitation vs the camera frame rates is due to python overhead in converting the video format.

