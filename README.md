# PI Zero Cam

This code will setup a PI cam service on http://<pi-address?:8889/cam 

to view the camera  video feed via http


## Hardware recipe

PI Zero 2 W (with or without headers)
NOIR or other PI Zero compatible camera
IR floodlight

Assemble to suit.

## Software recipe

Burn an SSD using the RPI imaged Raspberry OS 64 Bit.

Setup with a user of zero (or change the code) password and SSH as a mimimum.

Load the finished SSD.

ssh onto the pi when its avaialble on the network
adjust netowkr addressing type as needed dynamic/infrastructure

setup ssh keys to automate ssh

Run from your cloned repo.

```
./deploy.sh [pi-user pi-address ]
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


