This documents includes some useful profiling tools to profile your applications.

# Perf
* Install `linux-tools-generic`. You can also download source code of linux kernel, and run `make` in `tools/perf`.
* To check all the available performance counters, run `perf list`.
* To collect performance counters every one second (1000ms), run
`perf stat -e xxx,xxx,xxx -p <pid> (or -c <cores>) -g -I 1000`


# Systemtap

Here is a [tutorial](http://www.redbooks.ibm.com/redpapers/pdfs/redp4469.pdf) of systemtap. Sometimes, you'll have to download the source code of systemtap (don't use apt-get install), and update linux kernel to >=4.8.


# Flamegraph 
Here is the source code and introduction of [flamegraph](https://github.com/brendangregg/FlameGraph). Flamegraph can help you identify call stack of an application, and present the call graph in a very neat way.

Some other tools to generate stack traces:
  * `perf record` 
  * *sample-bt* in [systemtap-toolkit](https://github.com/openresty/openresty-systemtap-toolkit)


# Top & Htop
Linux *top*&*htop* help you monitor cpu utilization. To dump real-time *top* results to a file, run
    `top -p <pid> -d <refresh duration in second> -bn<#iterations> > filename`.
