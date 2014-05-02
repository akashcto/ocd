#!/bin/bash
. /config.sh
apt-get -y update
apt-get install -y python-httplib2
apt-get install -y python-pip
curl -o Jinja.tar.gz $URL_Jinja
mkdir Jinja/
tar --strip-components=1 -zxvf Jinja.tar.gz -C Jinja/
rm -rf Jinja.tar.gz
cd  Jinja
python setup.py install

cd

curl -o Werkzeug.tar.gz $URL_Werkzeug
mkdir Werkzeug/
tar --strip-components=1 -zxvf Werkzeug.tar.gz -C Werkzeug/
rm -rf Werkzeug.tar.gz
cd Werkzeug
python setup.py install

cd 
curl -o Flask.tar.gz $URL_Flask
mkdir Flask/
tar --strip-components=1 -zxvf Flask.tar.gz -C Flask/
rm -rf Flask.tar.gz
cd Flask
python setup.py install

cd / 
touch start.sh
echo "curl -o orchestrator.tar.gz $URL_Orchestrator" >> start.sh
echo "tar zxvf orchestrator.tar.gz" >> start.sh
echo "rm -rf orchestrator.tar.gz" >> start.sh
echo "cd orchestrator" >> start.sh
echo "python Router_general.py & sleep 1" >> start.sh
echo "python worker_router_general.py & sleep 1" >> start.sh 
echo "python checking_service.py & sleep 1" >> start.sh
echo "python dynamic_provisioning.py & sleep 1" >> start.sh
echo "python Job_Queue.py & sleep 1" >> start.sh
echo "python Resource_manager.py & sleep 1" >> start.sh
echo "python Router2.py & sleep 1" >> start.sh
echo "python worker_router2.py & sleep 1" >> start.sh
echo "python Provisioning_Server.py & sleep 1" >> start.sh 
echo "python provisioning_server_rest_client.py & sleep 1" >> start.sh
echo "python provisioning_rest_server.py" >> start.sh



