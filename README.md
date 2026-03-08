# PI Zero Cam

This code will setup a PI cam service on http://<pi-address?:8080 to view the camera  video feed.

If a display screen is attached via teh HDMI on boot, it will disply only on the screen for setup/aiming etc. 

Then reboot without the HDMI attached screen to setup the web served video.

This is workable code, and does not fulfill the ideal of the requiremetns in teh docs folder. Much was learned about waht is possible, with this tiny device, and what is not.

Practical limitations with it seem to be the device WIFI range. Testing is ongoing in that respect.

This prototype of ours is service as a lamb cam to see if we need to get up just yet, or not.

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

Once completed you should SSH onot the device as the 'pi' user

```
ssh pi@address
```
Enter your password and then cd into the scripts folder.

Execute the devbice setup script.

```
./device-setup.sh
```

This will setup a system level systemd process that starts on boot , detects if a screen is attached and displays the camera feed on it.
If the display is missing it sets up to sesrve https clients on port at at a reduced frame rate.

Once completed the process will be running and depedning on an attached display, either show the camera view on teh display, or via 

http://pi-address>:8080

The display rate is set to auto for a display setup, and  1280*720@15 fps for http. 

This limitation vs the camera frame rates is due to python overhead in converting the video format.

