# Install from the source code
```
  sudo apt-get -y install build-essential libssl-dev libpcre3-dev
  wget http://nginx.org/download/nginx-1.12.0.tar.gz
  tar xf nginx-1.12.0.tar.gz
  cd nginx-1.12.0
  sudo ./configure
  sudo make -j
  sudo make install
```
 
# Understand the source code
Here are two useful Chinese blogs (sorry it's in Chinese): 
* [blog1](https://www.cnblogs.com/muhy/p/10528543.html)
* [blog2](https://blog.csdn.net/weixin_43844810/article/details/90639433)

# Configure NGINX to its max performance

  * Here is a useful [link](http://nginx.org/en/docs/beginners_guide.html)
  * Configure CPU affinity: `worker_cpu_affinity` in *nginx.conf*
  * Configure [thread pool](http://nginx.org/en/docs/ngx_core_module.html?&_ga=1.68296344.843168382.1477489692%23accept_mutex) to make syscalls non blocking
  * [Open file cache](https://serverfault.com/questions/460275/how-to-choose-a-correct-value-for-open-file-cache-in-nginx-configuration) to cache file descriptors (This seems outdated. It may not be necessary for newer versions of NGINX). 
  * Too many open files? Add `worker_rlimit_nofile number` in *nginx.conf*. See this [link](https://gist.github.com/joewiz/4c39c9d061cf608cb62b).
  * Change `ulimit -n` to allow more concurrent open files.
  * Another useful [link](https://www.slashroot.in/nginx-web-server-performance-tuning-how-to-do-it)

# NGINX dataset
We configure NGINX to a static web engine. To generate random html files as NGINX's dataset, run the following command in bash (the example generates 800 160B files):
`for n in 160; do mkdir -p $n && for i in {0..800}; do perl gen_html.pl $n > $n/$i.html; done; done`
