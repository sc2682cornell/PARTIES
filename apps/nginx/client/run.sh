#!/bin/bash

## A script to run a test

RPS=$1
CLIENTS=$2
IP=$4
PORT=$5
PN=/home/sc2682/client/wrk2
MEASURE=$3
threads=1
let threads=32/CLIENTS
let CONN=threads*20

rm $PN/statistics/*

# Launch $CLIENTS NGINX clients (the for loop), i.e., $CLIENTS wrk2 instances.
# Each client has $threads threads, pinned to a specific set of CPU cores to avoid inteference between client threads (taskset -c $sta-$en). 
# Each client opens $CONN connections to the NGINX server, testing for $MEASURE seconds (-d).
# Tail latency is dumped periodically (every 100ms in PARTIES), using -p. You may need to change the wrk2 source code the adjust the frequency.
# scripts/multiplepaths.lua is used to have different wrk2 instances testing different paths. e.g., if the total dataset consists of 1000 html files, and we have 2 wrk2 instances, than the first instance only requests for the first 500 html files, and the second instance tests the last 500 html files. This step is not necessary, so -s multiplepaths.lua can be removed.

for i in `seq 1 $CLIENTS`
do
    let ii=i-1
    let sta=ii*threads
    let en=sta+threads-1
    taskset -c $sta-$en nice -n -20 $PN/wrk -c $CONN -p -t $threads -d $MEASURE --latency -s $PN/scripts/multiplepaths$i.lua --timeout 10000 -R $RPS http://$IP:$PORT > $PN/statistics/$i.txt &
    sleep 0.1
done

