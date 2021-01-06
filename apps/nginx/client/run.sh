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
for i in `seq 1 $CLIENTS`
do
    let ii=i-1
#    let sta=ii*threads+8
#    let en=sta+threads-1
    let sta=8
    let en=39
    if [ $i -lt 2 ]
    then
        taskset -c $sta-$en nice -n -20 $PN/wrk -c $CONN -p -t $threads -d $MEASURE --latency -s $PN/scripts/multiplepaths$i.lua --timeout 10000 -R $RPS http://$IP:$PORT > $PN/statistics/$i.txt &
        #taskset -c $sta-$en nice -n -20 $PN/wrk -c $CONN -t $threads -d $MEASURE --latency -s $PN/scripts/multiplepaths$i.lua --timeout 10000 -R $RPS http://$IP:$PORT > $PN/statistics/$i.txt &
    fi
    if [ $i -gt 1 ]
    then
        taskset -c $sta-$en nice -n -20 $PN/wrk -c $CONN -t $threads -d $MEASURE --latency -s $PN/scripts/multiplepaths$i.lua --timeout 10000 -R $RPS http://$IP:$PORT > $PN/statistics/$i.txt &
    fi
    sleep 0.1
done

