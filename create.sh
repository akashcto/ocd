#!/bin/bash
sudo docker -d & disown
#sudo rm /var/lib/docker/linkgraph.db
#sudo rm /var/run/docker.pid
sleep 10
cd Dockerfiles
sudo make
if ["$?" -ne "0" ]; then
  echo "Make Failed"
  exit 0
fi
echo "hello"
sudo rm /var/lib/docker/linkgraph.db
sudo rm /var/run/docker.pid
sleep 10
sudo docker -d & disown
sleep 10
sudo make
