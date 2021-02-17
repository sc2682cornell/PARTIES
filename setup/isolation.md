# Network 

Here is helpful [link](https://www.linux.com/training-tutorials/tc-show-manipulate-traffic-control-settings/) that introduces *qdisc*. 
 
*qdisc* is used to control the amount of network bandwidth allowed to the outside world (not the incoming network traffic). It should be configured for each server container, and the target IP is the client IP. Suppose the current network is called *eth0*.

#### Step 1: create your qdisc.
```
tc qdisc show dev eth0
tc qdisc del dev eth0 root
tc qdisc add dev eth0 root handle 1: htb
tc qdisc show dev eth0
```

#### Step 2: create your class.
```
tc class add dev eth0 parent 1: classid 1:[Flow ID] htb rate [rate]
tc class show dev eth0
```
Note: [Flow ID] is just a random integer. [rate] is the capped network bandwidth, such as 50mbit, 30gbit, the upper limit is 30gbit.


#### Step 3: create your filter.
`tc filter add dev eth0 protocol ip parent 1: prio 1 u32 match ip dst [target IP address] flow`

#### To change the network bandwidth.
`tc class change dev eth0 parent 1: classid 1:[Flow ID] htb rate [new rate]`

#### To delete your qdisc.
```
tc qdisc show dev eth0
tc filter del dev eth0 parent 1: proto ip prio 1 handle 800::801 u32
tc qdisc del dev eth0 root
```     
Note: 800:801 is obtained from running `qdisc show`

# Power 
Here is an introduction to [RAPL](https://www.kernel.org/doc/Documentation/power/powercap/powercap.txt).
In PARTIES, we indirectly manage power consumption by managing frequency (see below).

# Frequency (per-core DVFS)

First, install cpupower. To check the current frequency driver, run
  `cpupower frequency-info`

Currently only the ACPI frequency driver supports per-core DVFS. To change the freuqency driver from *intel_pstate* to *acpi*, please see this [link](https://unix.stackexchange.com/questions/121410/setting-cpu-governor-to-on-demand-or-conservative). In short, you need to add `intel_pstate=disable` in the kernel argument list.

Here is more information about [ACPI](https://wiki.archlinux.org/index.php/CPU_frequency_scaling).

To change the governor to userspace and allow user-defined frequencies, run:
```
cpupower frequency-set -g userspace
cpupower -c <cores> frequency-set -f <frequency>
```

# Last-level Cache 
A basic introduction of Intel RDT: Chapter 17.17 & 17.18 of the [Software Manual](https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf).

Since we only need CAT from the Intel RDT, you can simply install *pqos* [here](https://github.com/intel/intel-cmt-cat/tree/master/pqos). Check out its [wiki page](https://github.com/intel/intel-cmt-cat/wiki/Usage-Examples) in the GitHub repo for more detailed usage.

My most frequently used commands are: 
```
pqos -s
pqos -e "llc:1=0x000f" // set COS1 to only using four cache ways
pqos -a "llc:1=0-10"   // bind core 0-10 to COS1, i.e., core 0-10 can only use four cache ways, and they will share the four ways.
```

# Core and memory capacity
See [lxc.md](https://github.com/sc2682cornell/PARTIES/blob/main/setup/lxc.md).

# Miscellaneous
#### To root ssh to a remote machine:
  1. Open `/etc/ssh/sshd_config`, add `PermitRootLogin yes` to the file. Then run `service ssh restart`.
  2. Add the IP address of the remote machine to `/etc/security/access.conf` in the local machine.
  3. To ssh without password, check out this [link](http://www.linuxproblem.org/art_9.html).

#### Additional setup.
Due to the default setup of our servers, when a server is rebooted, we need to run the following lines to modify iptables (this step may not be necessary for other groups):
  ```
iptables -L input --line-numbers
iptables -D input <the number of the line that drops all requests>
  ```
Then, use `ping` and`trace route` to double check that this line is deleted successfully.

