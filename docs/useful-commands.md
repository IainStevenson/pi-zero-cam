nala install -y iperf3 iftop nload 


useful commands 

watch -n2 iw dev wlan0 link # how well is the connection setup
iperf - c pc-iain.my.lan -t 60 # a 60 second performande test to a Lan device across the WIFI 
cat /proc/net/dev # what is the netowkr doing right now. 

nload wlan0


iw dev wlan0 station dump
