#!/bin/bash

# This script does port forwarding, which forwards a port in the container to a port in the machine. For example, if the IP address of a container that runs memcached is 10.0.3.117 ($OUT_IP), and the port that memcached uses is 11211 ($OUT_PORT). The name of the machine is "em1" ($IN_IP, you can get it by running "ifconfig"). You want to map to port 11000 ($IN_PORT) such that 10.0.3.117:11211 is equivalent to em1:11000. This is because ports of the container are not visible to the outside world. For clients to reach the container, the container mush expose some of its ports to the host.  

# Interesting link about Receive Side Scaling (RSS) : https://docs.microsoft.com/en-us/windows-hardware/drivers/network/introduction-to-receive-side-scaling

OUT_IP=$1   # e.g. 10.0.3.117
OUT_PORT=$2 # e.g. 11211
IN_IP="em1" 
IN_PORT=$3  # e.g. 11000

let OPORT=$OUT_PORT;
let IPORT=$IN_PORT;
sudo iptables -t nat -A PREROUTING -p tcp -i $IN_IP --dport $IPORT -j DNAT --to-destination $OUT_IP:$OPORT
sudo iptables -t nat -A POSTROUTING -p tcp -d $OUT_IP --dport $OPORT -j MASQUERADE
