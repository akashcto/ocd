#!/bin/bash
sudo docker -d & disown
sudo rm /var/lib/docker/linkgraph.db
sudo rm /var/run/docker.pid
sudo docker -d & disown
cd ocd/Dockerfiles
sudo make 
