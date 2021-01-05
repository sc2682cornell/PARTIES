bash moveirq.sh

# initiate frequency and cache allocations
cpupower -c 0-87 frequency-set -g performance
pqos -a "llc:0=0-87"

# stop all the containers
#lxc-stop -n shuang_memcached
#lxc-stop -n shuang_nginx
#lxc-stop -n shuang_xapian
#lxc-stop -n shuang_moses
#lxc-stop -n shuang_sphinx
#lxc-stop -n shuang_mongodb

# start all the containers and perform port forwarding for each container that runs a specific service
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


