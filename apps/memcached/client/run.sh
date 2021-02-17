#!/bin/bash

THREADS=$1
MEASURE=$2
SIZE=$3
VALUE=$4
QPS=$5
TIMES=$6
IP=$7
PORT=$8
CONN=10
PP=/home/sc2682/client/mutated
PO=/filer-01/datasets/memcached
#rm -rf $PP/statistics
mkdir -p $PP/statistics
CPU=(4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39)

# If this is the first time to test using mutated, you need to run load_memcache first to load the dataset to the memcached server. However, you don't need to load again later unless your memcached server is rebooted.
#echo "load..."
#$PP/client/load_memcache -z 4000000 -v 200 128.253.128.65:11000


# Launch $THREADS memcached clients (the for loop).
# Each client is pinned to a specific CPU core to avoid inteference between client threads (taskset).
# Each client opens $CONN connections to the memcache server, testing for $MEASURE seconds (-s).
# The dataset consists of $SIZE items (-z), each item size is $VALUE bytes (-v).
# Request inter-arrivial times follow an exponential distribution (-d norm).
# Tail latency is dumped periodically (every 100ms in PARTIES), to $PO/real_$ii.txt (-x).

for i in `seq 1 $THREADS`
do   
    let k=(TIMES-1)*THREADS+i 
    let b=(i-1)*SIZE
    let ii=i-1
    taskset -c ${CPU[$i]} nice -n -20 $PP/client/mutated_memcache -r -n $CONN -W 10000 -w 5 -d norm -z $SIZE -Z $b -v $VALUE -x $PO/real_$ii.txt -s $MEASURE $IP:$PORT $QPS > $PP/statistics/$k.txt &
    sleep 0.1
done

