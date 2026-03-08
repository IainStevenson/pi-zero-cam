# PI Zero Cam

This code will setup a PI cam service on tcp/h264://<pi-address?:8554 to view the camera  video feed via aps like VLC

NOTE: IoS version wont work.


This is workable code but a work in progress towards something more functional. 

It does not fulfill the ideal of the requirements in the docs folder. Much was learned about what is possible, with this tiny device, and what is not.

Practical limitations with it seem to be the device WIFI range. Testing is ongoing in that respect.

Note: WIFI Access Point performance is a black are at times.

This prototype of ours is service as a 'lamb cam' to see if we need to get up just yet, or not.

## Hardware recipe

PI Zero 2 W (with or without headers)
NOIR or other PI Zero compatible camera
IR floodlight

Assemble

## Software recipe

Burn an SSD using the RPI imaged Raspberry OS 64 Bit.

Setup with a user of zero (or change the code) password and SSH as a mimimum.

Load the finished SSD.

Run from your cloned repo.

```
./device-deploy.sh
```

Enter your device IP address. (adjust the deploy script as necessary)
Enter your password used for the pi SSD OS card. It will ask a few times.

Once completed you should SSH onto the device as the 'pi' user

```
ssh zero@address
```
Enter your password and then cd into the scripts folder.

Execute the device setup script.

```
./device-setup.sh
```

This will setup a system level systemd process that starts on boot.

The display rate is set to  1280*720@30 fps and capped at 1.5Mbps bandwidth usage. 


