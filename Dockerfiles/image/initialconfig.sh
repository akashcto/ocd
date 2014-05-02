#!/bin/bash
touch /config.sh
#echo "export BEHIND_PROXY=1" >> /config.sh
#echo "export LINK1=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles" >> /config.sh
#echo "export URL_JDK=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/jdk-7u25-linux-x64.tar.gz" >> /config.sh
#echo "export URL_ChefClient=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/chef_11.8.0-1.ubuntu.12.04_amd64.deb" >> /config.sh
#echo "export URL_ClientFile=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/client.rb" >> /config.sh
#echo "export URL_JavaFramework=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/Services_JAVA_DOCKER.tar.gz" >> /config.sh
#echo "export URL_GitPlugin=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/GitPlugin-jar-with-dependencies.jar" >> /config.sh
#echo "export URL_CodeStyle=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/CodeStyleService-jar-with-dependencies.jar" >> /config.sh
#echo "export URL_BuildService=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/JenkinsBuildService-jar-with-dependencies.jar" >> /config.sh
#echo "export URL_Maven=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/apache-maven-3.1.1-bin.tar.gz" >> /config.sh
#echo "export URL_Ant=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/apache-maven-3.1.1-bin.tar.gz" >> /config.sh
#echo "export URL_JenkinsLibs=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/jenkinsLibs.tar.gz" >> /config.sh
#echo "export URL_JenkinsWar=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/jenkins.war" >> /config.sh
#echo "export URL_Nexus=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/nexus.tar.gz" >> /config.sh
#echo "export URL_Orchestrator=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/orchestrator.tar.gz" >> /config.sh
#echo "export URL_Meteor=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/meteor.tar.gz" >> /config.sh
#echo "export URL_MeteorSetup=http://10.114.10.200:8081/nexus/content/repositories/chef_test/dockerFiles/meteor.sh" >> /config.sh


echo "export BEHIND_PROXY=0" >> /config.sh
echo "export LINK1=https://s3-ap-northeast-1.amazonaws.com/ocd-framework" >> /config.sh
echo "export URL_JDK=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/jdk-7u25-linux-x64.tar.gz" >> /config.sh
echo "export URL_ChefClient=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/chef_11.8.0-1.ubuntu.12.04_amd64.deb" >> /config.sh
echo "export URL_ClientFile=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/client.rb" >> /config.sh
echo "export URL_JavaFramework=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/Services_JAVA_DOCKER.tar.gz" >> /config.sh
echo "export URL_GitPlugin=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/GitPlugin-jar-with-dependencies.jar" >> /config.sh
echo "export URL_CodeStyle=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/CodeStyleService-jar-with-dependencies.jar" >> /config.sh
echo "export URL_BuildService=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/JenkinsBuildService-jar-with-dependencies.jar" >> /config.sh
echo "export URL_Maven=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/apache-maven-3.1.1-bin.tar.gz" >> /config.sh
echo "export URL_Ant=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/apache-ant-1.9.3-bin.tar.gz" >> /config.sh
echo "export URL_JenkinsLibs=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/jenkinsLibs.tar.gz" >> /config.sh
echo "export URL_JenkinsWar=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/jenkins.war" >> /config.sh
echo "export URL_Nexus=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/nexus.tar.gz" >> /config.sh
echo "export URL_Orchestrator=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/orchestrator.tar.gz" >> /config.sh
echo "export URL_Meteor=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/meteor.tar.gz" >> /config.sh
echo "export URL_MeteorSetup=https://s3-ap-northeast-1.amazonaws.com/ocd-framework/meteor.sh" >> /config.sh



echo "export URL_ZMQ=http://download.zeromq.org/zeromq-3.2.3.tar.gz" >> /config.sh
echo "export URL_Jinja=https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz#md5=1c49a8825c993bfdcf55bb36897d28a2" >> /config.sh
echo "export URL_Werkzeug=https://pypi.python.org/packages/source/W/Werkzeug/Werkzeug-0.8.3.tar.gz#md5=12aa03e302ce49da98703938f257347a" >> /config.sh
echo "export URL_Flask=https://pypi.python.org/packages/source/F/Flask/Flask-0.8.1.tar.gz#md5=4b9e866bf43723d834b3ce8fcd13574d" >> /config.sh
echo "export URL_Node=http://nodejs.org/dist/v0.10.22/node-v0.10.22-linux-x64.tar.gz" >> /config.sh
