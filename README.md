# PARTIES
PARTIES is a resource manager that manages and partitions hardware resources for colocated latency-critical(LC) services on the same server node. It enables one or more LC services to share a physical node without QoS violations. PARTIES leverages a set of hardware and software resource partitioning mechanisms to adjust allocations dynamically at runtime, in a way that meets the QoS requirements of each co-scheduled workload, and maximizes throughput for the machine. For more details, please check out [the PARTIES paper](https://dl.acm.org/doi/10.1145/3297858.3304005) ([PDF](https://sc2682cornell.github.io/pdf/iiswc17.pdf)).

# PARTIES repository structure

## setup

* **lxc.md**: notes to set up Linux Container (LXC).
* **portfow.sh**: bash script to set up network port forwarding, required by LXC.
* **moveirq.sh**: bash script to reserve cores for IRQ (network interrupts).
* **restart.sh**: bash script to re-set up the environment after the physical machine is rebooted.
* **isolation.md**: notes to set up hardware and software partitioning mechanims.
* **profile.md**: notes of some useful profiling tools, to help understand your applications.

## apps

#### Memcached
 
* **server/README.md**: instructions to install the Memcached server application
* **client/README.md**: instructions to install the Memcached client (load generator)
* **client/run.sh**: bash script to run the clients to test Memcached server performance

#### Nginx

* **server/README.md**: instructions to install the NGINX server application
* **server/config**: an example of the NGINX LXC config
* **server/nginx.conf&default**: NGINX configurations
* **server/gen_html.pl**: Perl script to generate NGINX datasets. Instructions also included in README.md.
* **client/README.md**: instructions to install the NGINX client, wrk2
* **client/run.sh**: bash script to run the wrk2 load generator to test NGINX

#### MongoDB

* **server/README.md**: instructions to install the MongoDB server application
* **client/README.md**: instructions to install YCSB. 
* **client/workload**: a configuration file that YCSB needs
* **client/run.sh**: bash script to run the YCSB load generator to test MongoDB

#### Tailbench (Xapian, Moses, Sphinx)

* **tailbench.md**: notes to install Tailbench.

## manager

* **PARTIES.py**: Python script for the PARTIES controller.
* **config.txt**: sample input of the PARTIES controller.
* **monitorN.py**: Python script to monitor real-time usage of hardware resources. Not mandotory in the PARTIES controller. 
* **README.md**: notes to use the PARTIES controller


# License & Copyright
PARTIES is free software; you can redistribute it and/or modify it under the terms of the [MIT License](LICENSE).

PARTIES was originally written by Shuang Chen at Cornell University, and per Cornell University policy, the copyright of this original code remains with the Board of Trustees of Cornell University. 

If you use this software in your research, we request that you reference [the PARTIES paper](https://dl.acm.org/doi/10.1145/3297858.3304005) ("PARTIES: QoS-Aware Resource Partitioning for Multiple Interactive Services", Shuang Chen, Christina Delimitrou, José F. Martínez, ASPLOS, April 2019), and that you send us a citation of your work.
