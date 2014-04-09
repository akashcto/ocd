#!/bin/bash

sudo su -c "knife cookbook upload --all"
sudo java -jar /home/vagrant/dockerprov-1.0-SNAPSHOT-jar-with-dependencies.jar &
#sudo ruby /home/vagrant/entire10-3.rb -o 0.0.0.0
sudo ruby /home/vagrant/queue.rb &
sudo ruby /home/vagrant/add_to_runlist.rb -o 0.0.0.0
