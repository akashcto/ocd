#!/bin/bash
. /config.sh
if [ "$BEHIND_PROXY" = 1 ]; then
	touch /etc/apt/apt.conf
	echo 'Acquire::http::proxy "http://gp2272:india{2020@proxy1.wipro.com:8080/";' >> /etc/apt/apt.conf
	echo 'Acquire::https::proxy "http://gp2272:india{2020@proxy1.wipro.com:8080/";' >> /etc/apt/apt.conf
	echo 'Acquire::ftp::proxy "http://gp2272:india{2020@proxy1.wipro.com:8080/";' >> /etc/apt/apt.conf
	 
fi
apt-get install -y curl
apt-get install -y nano
apt-get install -y wget
touch /.curlrc 
if [ "$BEHIND_PROXY" = 1 ]; then
	
	echo "proxy=http://gp2272:india{2020@proxy4.wipro.com:8080" >> /.curlrc
        . /.curlrc
	touch /etc/wgetrc
	echo "https_proxy = http://gp2272:india{2020@proxy1.wipro.com:8080/" >> /etc/wgetrc
        echo "http_proxy = http://gp2272:india{2020@proxy1.wipro.com:8080/" >> /etc/wgetrc
        echo "ftp_proxy = http://gp2272:india{2020@proxy1.wipro.com:8080/" >> /etc/wgetrc
	echo "export ftp_proxy=http://gp2272:india{2020@proxy1.wipro.com:8080" >> /config.sh
        echo "export http_proxy=http://gp2272:india{2020@proxy1.wipro.com:8080/" >> /config.sh
        echo "export https_proxy=http://gp2272:india{2020@proxy1.wipro.com:8080/" >> /config.sh


fi

