To install memcached from the source code:
```
  sudo apt-get build-dep memcached -y
  wget http://memcached.org/files/memcached-1.4.36.tar.gz
  tar xf memcached-1.4.36.tar.gz
  cd memcached-1.4.36
  ./configure
  make
  sudo make install
```

