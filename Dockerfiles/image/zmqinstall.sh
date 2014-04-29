#!/bin/bash
. /config.sh
apt-get -y update
apt-get install -y python2.7
apt-get install -y python-setuptools python-virtualenv python-dev
apt-get install -y python-zmq

curl -o zeromq.tar.gz $URL_ZMQ
mkdir zeromq/
tar --strip-components=1 -zxvf zeromq.tar.gz -C zeromq/
cd zeromq
./configure
make
make install
ldconfig
cd ..
ldconfig
