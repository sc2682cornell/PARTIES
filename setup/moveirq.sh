#!/bin/bash

# This script exclusively reserve certain cores (0-7 in this case) to handle network interrups so that IRQs don't interfere with application threads. The number of IRQ cores is decided based on profiling core utiliation upon the maximum network traffic, i.e., when network bandwidth is fully saturated, what's the minimum number of IRQ cores such that IRQ cores are slightly below 100% utilization.

cat /proc/interrupt # find cores that handle IRQ interrups. 
ls /proc/irq # check out this directory for more details about IRQ cores, such as default_smp_affinity

for i in "42" "43" "44" "45" "46" "47" "48" "49" # change the loop list accordingly
do
    cat /proc/irq/$i/smp_affinity_list
    cat /proc/irq/$i/smp_affinity
done

# Reserve core 0-7 as IRQ cores to handle network interrupts
echo 0 > /proc/irq/42/smp_affinity_list
echo 1 > /proc/irq/43/smp_affinity_list
echo 2 > /proc/irq/44/smp_affinity_list
echo 3 > /proc/irq/45/smp_affinity_list
echo 4 > /proc/irq/46/smp_affinity_list
echo 5 > /proc/irq/47/smp_affinity_list
echo 6 > /proc/irq/48/smp_affinity_list
echo 7 > /proc/irq/49/smp_affinity_list
