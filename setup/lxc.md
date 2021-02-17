Cheatsheet of linux container (LXC)

# Basic Operations

#### Install LXC
```
sudo apt-get install lxc
sudo lxc-ls 
```

#### Print basic info of a container
`sudo lxc-info -n <name-of-container>`   

#### Create a container with Ubuntu
`sudo lxc-create -t ubuntu -n <name-of-container>`    

#### Start a container
`sudo lxc-start -d -n <name-of-container>`   

#### Enter the container. Ctrl-a q to exit
`sudo lxc-console -n <name-of-container>`    

#### Execute a command inside a container
`sudo lxc-attach -n <name-of-container> -- <command> `  

#### Delete a container
`sudo lxc-destroy -n <name-of-container>`    


# Install packages inside LXC 
Modify /etc/apt/source.list, and then
```
sudo apt-get update
sudo apt-get upgrade
```

# Resource isolation

#### Check allocated cores of a container
`sudo lxc-cgroup -n <name-of-container> cpuset.cpus`   

#### Pin the container to a specific set of cores (0,2,4 in this case)
`sudo lxc-cgroup -n <name-of-container> cpuset.cpus 0,2,4`    

#### Check memory capacity limitation of a container
`sudo lxc-cgroup -n <name-of-container> memory.limit_in_bytes`    

#### Set memory limit (1G in this case)
`sudo lxc-cgroup -n <name-of-container> memory.limit_in_bytes 1G`   


# Network Port Forwarding 

Once the server application is running inside the container, to communicate with the outside world, we need to set up port forwarding. Please check out [portforw.sh](https://github.com/sc2682cornell/PARTIES/blob/main/setup/portforw.sh) for the detailed steps.

To delete or change the forwarding, do the following commands in iptables:
```
iptables -t nat -L --line-numbers
iptables -t nat -D PREROUTING <line-number>
```
