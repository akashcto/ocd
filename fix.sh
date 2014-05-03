#!/bin/bash
sudo rm /var/lib/docker/linkgraph.db
sudo rm /var/run/docker.pid
sudo docker -d & disown
sleep 10
cd Dockerfiles
sudo make
