#!/bin/bash
. /config.sh
echo "deb http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main" >> /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/natecarlson/maven3/ubuntu precise main" >> /etc/apt/sources.list
apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y install curl build-essential libxml2-dev libxslt-dev git
apt-get install -y build-essential
