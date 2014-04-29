#!/bin/bash
. /config.sh
export CXXFLAGS="-I $(readlink -f ../include)"
export LDFLAGS="-L $(readlink -f ../lib) -Wl,-rpath=$(readlink -f ../lib)"

curl -o node.tar.gz $URL_Node
mkdir node/
tar --strip-components=1 -zxvf node.tar.gz -C node/
rm -rf node.tar.gz
echo "export PATH=$PATH:/node/bin/" >> /root/.bashrc
export PATH=$PATH:/node/bin/
. /root/.bashrc
npm install node-gyp rebuild
npm install zmq
ldconfig
echo tlsv1 > $HOME/.curlrc
curl -o meteor.sh $URL_MeteorSetup
sh meteor.sh
cd /
touch start.sh
echo "export PATH=$PATH:/node/bin" >> start.sh
echo "curl -o meteor.tar.gz $URL_Meteor" >> start.sh
echo "mkdir docmet/" >> start.sh
echo "tar --strip-components=1 -zxvf meteor.tar.gz -C docmet/" >> start.sh
echo "rm -rf meteor.tar.gz" >> start.sh
echo "cd docmet" >> start.sh
echo "meteor" >> start.sh


