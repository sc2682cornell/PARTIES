#!/bin/bash

RPS=150
THREADS=64
IP=128.253.128.76
PORT=27000
PN=/home/sc2682/client/ycsb_bin

taskset -c 4-39 nice -n -20 $PN/bin/ycsb run mongodb -p mongodb.url=mongodb://$IP:$PORT/ycsb -s -P workload -threads $THREADS -target $RPS 
