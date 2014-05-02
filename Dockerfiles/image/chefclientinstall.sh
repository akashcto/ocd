#!/bin/bash
. /config.sh
apt-get -y update
curl -o chef_client.deb $URL_ChefClient
dpkg -i chef_client.deb
rm -rf chef_client.deb
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
export PATH=$PATH:/opt/chef/embedded/bin:/opt/chef/bin
mkdir /etc/chef/
cd /etc/chef
curl -O $URL_ClientFile
cd ../../
touch start.sh
echo 'hsname=$(hostname)' >> start.sh
echo 'curl --data "name=$hsname" http://172.17.42.1:4567/ip' >> start.sh
echo "umount /etc/hosts && echo '172.17.42.1 testchefserver.wipro.com' >> /etc/hosts" >> start.sh
echo 'echo "127.0.0.1 localhost $hsname" >> /etc/hosts' >> start.sh
echo "echo '::1 localhost ip6-localhost ip6-loopback' >> /etc/hosts" >> start.sh
echo "chef-client -i 60" >> start.sh



