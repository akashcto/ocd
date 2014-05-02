sudo docker kill chef-server
sudo docker kill $(sudo docker ps | grep " pandrew/chef-client:latest")
sudo docker run -d -i -t -h testchefserver.wipro.com -name "chef_server" -p 0.0.0.0:443:443 -p 0.0.0.0:4568:4568 -p 0.0.0.0:5570:5570 wipro/ocd-chefserver:0.1.0 /bin/bash
sleep 120
