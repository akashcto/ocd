#!/bin/bash
. /config.sh
apt-get update
curl -o apache-maven.tar.gz $URL_Maven
mkdir apache-maven/
tar --strip-components=1 -zxvf apache-maven.tar.gz -C apache-maven/
rm -rf apache-maven.tar.gz
curl -o apache-ant.tar.gz $URL_Ant
mkdir apache-ant/
tar --strip-components=1 -zxvf apache-ant.tar.gz -C apache-ant/
rm -rf apache-ant.tar.gz
apt-get install -y  git
curl -o jenkinsLibs.tar.gz $URL_JenkinsLibs
curl -O $URL_JenkinsWar
mkdir /home/jenkins
mkdir /home/jenkins/.m2/
tar zxvf jenkinsLibs.tar.gz
rm -rf jenkinsLibs.tar.gz
cd /
git config --global http.sslverify false
git clone https://27c02b7623c71b2e7cf7593dc9a0f1425c6dc6f9@github.com/akashcto/broadleaf.git

cd /root
echo "export M2_HOME=/apache-maven/" >> .bashrc
echo "export ANT_HOME=/apache-ant/" >> .bashrc
echo 'export PATH=$PATH:/apache-ant/bin/:/apache-maven/bin/' >> .bashrc
echo "export JENKINS_HOME=/.jenkins" >> .bashrc
. .bashrc
cd ../
touch start.sh
echo "export M2_HOME=/apache-maven/" >> start.sh
echo "export ANT_HOME=/apache-ant/" >> start.sh
echo 'export PATH=$PATH:/apache-ant/bin/:/apache-maven/bin/' >> start.sh
echo "export JENKINS_HOME=/.jenkins" >> start.sh
echo "cd /broadleaf" >> start.sh
echo "mvn clean install" >> start.sh
echo "cd /broadleaf/site" >> start.sh
echo "ant start-db" >> start.sh
echo "ant create-sql" >> start.sh
echo "cd ../../" >> start.sh
echo "java -jar jenkins.war">> start.sh

