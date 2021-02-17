#!/bin/bash

RPS=$1
THREADS=64 # This number should be set to sufficiently large.
IP=128.253.128.76 # IP address of the MongoDB server
PORT=27000  # Port number of the MongoDB server
PN=/home/sc2682/client/ycsb_bin # Path to the YCSB binary

# Run YCSB with $THREADS threads, on a set of cores (taskset), using the workload description (-P workload), with the target request-per-set (-target $RPS)

taskset -c 4-39 nice -n -20 $PN/bin/ycsb run mongodb -p mongodb.url=mongodb://$IP:$PORT/ycsb -s -P workload -threads $THREADS -target $RPS 
