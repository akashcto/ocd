#!/bin/bash
docker run -d -i -t -p 0.0.0.0:8081:8081 wipro/ocd-nexus:0.1.0 bash start.sh
docker run -d -i -t -p 0.0.0.0:8080:8080 wipro/ocd-jenkins:0.1.0 bash start.sh
sleep 60
docker run -d -i -t -p 0.0.0.0:5556:5556 -p 0.0.0.0:5557:5557 -p 0.0.0.0:3335:3335 -p 0.0.0.0:8899:8899 -p 0.0.0.0:4445:4445 -p 0.0.0.0:5559:5559 -p 0.0.0.0:6666:6666 -p 0.0.0.0:6665:6665 -p 0.0.0.0:5561:5561 -p 0.0.0.0:7770:7770 -p 0.0.0.0:7779:7779 wipro/ocd-orchestrator:0.1.0 bash start.sh
docker run -d -i -t -p 0.0.0.0:5566:5566 -p 0.0.0.0:5568:5568 -p 0.0.0.0:5560:5560 -p 0.0.0.0:7789:7789 -p 0.0.0.0:5555:5555 wipro/ocd-javaservice:0.1.0 bash start.sh
sleep 10
docker run -d -i -t -h testchefserver.wipro.com -name "chef_server" -p 0.0.0.0:443:443 -p 0.0.0.0:4568:4568 -p 0.0.0.0:5570:5570 wipro/ocd-chefserver:0.1.0 bash start.sh
sleep 120
mkdir /etc/chef-server/
docker cp chef-server:/etc/chef-server/chef-validator.pem /etc/chef-server/
docker tag wipro/ocd-chefclient:0.1.0 pandrew/chef-client

docker run -d -i -t -p 0.0.0.0:3000:3000 -p 0.0.0.0:8050:8050 -p 0.0.0.0:7050:7050 wipro/ocd-meteor:0.1.0 bash start.sh
