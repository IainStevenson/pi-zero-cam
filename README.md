# PI Zero Cam

This code will setup a PI cam service using `mediamtx` on `http://<pi-address>:8889/cam` 


## Hardware recipe

PI Zero 2 W (with or without headers)
attach a NOIR or other PI Zero compatible camera
IR floodlight if a NOIR camera is attached and night viewing desired.
A case of some sort
Power adapters for all.
SSD card

Assemble to suit.

## Software recipe

Use the latest RPI Imager to flash the SSD using the Raspberry OS 64 Bit.

Setup with your WIFI SSID and password, a user of 'zero' (or change the code to your specification) user password and enable SSH as a mimimum. The default PI imaged username is `pi`

Load the finished SSD onto the PI.

Boot

ssh onto the pi when its available on the network

I recommend setting up an SSH key and copying that to the pi first off.


adjust network addressing type as needed, leave as DHCP dynamic or opt for infrastructure with a fixed IP



Change the `inventory.ini` as needed. Replace `zero-cam` with your devices IP address or DNS name if you have one, and the `ansible_user` value with your chosen username when you flashed the image.

Run the playbook via;

```
./run
```

Once completed you should SSH onto the device as the 'pi' device user, e.g.

```
ssh zero@address
```
Enter your password and then cd into the scripts folder.

You can monitor the camera service via either

```
sudo systemctl status  pi-zero-cam-streaming.service
```

or

```
sudo journalctl -u pi-zero-cam-streaming.service -f
```




TO DO

sudo nano /etc/NetworkManager/conf.d/wifi-powersave.conf

```                                                        
[connection]
wifi.powersave = 2
```



zero@zero-cam:~ $ sudo iw dev wlan0 set power_save off