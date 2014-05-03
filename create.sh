#!/bin/bash
sudo docker -d & disown
#sudo rm /var/lib/docker/linkgraph.db
#sudo rm /var/run/docker.pid
sleep 10
cd Dockerfiles
sudo make 
