#!/bin/bash

TARGET_IP="128.253.128.65"
NET="em1"
BANDWIDTH="10gbit"
FLOW_ID=111

tc qdisc show dev $NET
tc qdisc del dev $NET root
tc qdisc add dev $NET root handle 1: htb
tc filter add dev $NET protocol ip parent 1: prio 1 u32 match ip dst $TARGET_IP flowid 1:$FLOW_ID
tc class add dev $NET parent 1: classid 1:$FLOW_ID htb rate $BANDWIDTH
tc class show dev $NET
#To change the network bandwidth
#tc class change dev eth0 parent 1: classid 1:$FLOW_ID htb rate $NEW_BW


