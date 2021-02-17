# Run this script if your physical machine is rebooted, when the IRQ cores, containers, frequency & cache settings are reset to default.

# Set up IRQ cores
bash moveirq.sh

# Set frequency to nominal frequency. Our system has 88 cores (-c 0-87), and the nominal frequency is 2.2GHz.
cpupower -c 0-87 frequency-set -g userspace
cpupower -c 0-87 frequency-set -f 2.2GHz

# Set cache allocations. Set all the cores (core 0-87) to COS 0, which has all the cache ways by default.
pqos -a "llc:0=0-87"

# Start all the containers and perform port forwarding for each container that runs a specific service
# Our system has 6 services.
lxc-start -d -n shuang_memcached
bash portforw.sh 10.0.3.117 11211 11000
lxc-start -d -n shuang_nginx
bash portforw.sh 10.0.3.149 80 88 
lxc-start -d -n shuang_xapian
bash portforw.sh 10.0.3.148 8080 8880
lxc-start -d -n shuang_moses
bash portforw.sh 10.0.3.8 8080 8884
lxc-start -d -n shuang_sphinx
bash portforw.sh 10.0.3.172 8080 8881
lxc-start -d -n shuang_mongodb
bash portforw.sh 10.0.3.150 27017 27000


