#!/bin/bash
#Shell to start Jenkins Service :

echo 'Shell Execution Started '  > ./jenkins.log

rm -rf $JENKINS_HOME
echo $JENKINS_HOME

. ./config.properties

echo "Jenkins war download URL : "$jenkins_download_url >> ./jenkins.log
echo "Jenkins Config File download URL : "$jenkins_config_url >> ./jenkins.log
echo "Jenkins Home URL : "$jenkins_home_url >> ./jenkins.log
echo "Jenkins URL : http://localhost:8080${jenkins_home_url}" >> ./jenkins.log
echo "Jenkins-Cli url http://localhost:8080${jenkins_home_url}jnlpJars/jenkins-cli.jar" >> ./jenkins.log

compressed_configfile_name=$(echo $jenkins_config_url | awk -F/ '{print $(NF)}')

echo "Config file Name : "$compressed_configfile_name >> ./jenkins.log

if [ ! -f jenkins.war ];
	then
		sleeptime=30
		echo "jenkins.war Does Not Exist" >> ./jenkins.log
		echo "Downloading jenkins.war" >> ./jenkins.log
		wget $jenkins_download_url
		echo "jenkins.war File Downloaded " >> ./jenkins.log
	else
		echo "jenkins.war already Exist" >> ./jenkins.log
		sleeptime=20
fi

echo "Starting Jenkins " >> ./jenkins.log

java -jar jenkins.war &

sleep $sleeptime

if [ ! -f jenkins-cli.jar ];
	then
		echo "jenkins-cli.jar Does Not Exist" >> ./jenkins.log
		echo "Downloading jenkins-cli.jar" >> ./jenkins.log
		wget http://localhost:8080${jenkins_home_url}jnlpJars/jenkins-cli.jar
		echo "jenkins-cli.jar File Downloaded " >> ./jenkins.log
	else
		echo "jenkins-cli.jar already Exist"  >> ./jenkins.log
fi

while read url
	do
		plugin_name=$(echo $url | awk -F/ '{print $(NF)}' | awk -F. '{print $1}')
		echo "Installing Plugin : " $plugin_name >> ./jenkins.log
		java -jar jenkins-cli.jar -s http://localhost:8080$jenkins_home_url install-plugin $url -deploy
	done < ./plugin
		
if [ ! -f $compressed_configfile_name  ];
	then
		echo "$compressed_configfile_name Does Not Exist" >> ./jenkins.log
		echo "Downloading $compressed_configfile_name" >> ./jenkins.log
		wget $jenkins_config_url
		echo "$compressed_configfile_name File Downloaded " >> ./jenkins.log
	else
		echo "$compressed_configfile_name already Exist"  >> ./jenkins.log
fi	

echo "Untaring $compressed_configfile_name" >> ./jenkins.log

tar -zxvf $compressed_configfile_name

cd ./Tmplate/

java_home_path=$(echo $JAVA_HOME | sed 's/\//\\\//g')
echo "Setting JAVA_HOME $java_home_path" >> ./jenkins.log
sed "s/<home>JAVA_HOME<\/home>/<home>$java_home_path\/<\/home>/g" config_template.xml >> config.xml

gitlocation=$(which git | sed 's/\//\\\//g')
echo "Setting GIT_PATH $gitlocation" >> ./jenkins.log
sed "s/<home>GIT_PATH<\/home>/<home>$gitlocation<\/home>/g" hudson.plugins.git.GitTool_template.xml >> hudson.plugins.git.GitTool.xml

mvnlocation=$(which mvn | awk -F/bin/ '{print $1}' | sed 's/\//\\\//g')
echo "Setting MVN_PATH $mvnlocation" >> ./jenkins.log
sed "s/<home>MVN_PATH<\/home>/<home>$mvnlocation\/<\/home>/g" hudson.tasks.Maven_template.xml >> hudson.tasks.Maven.xml

antllocation=$(which ant)
echo "Setting ANT_PATH $antllocation" >> ./jenkins.log
if [ -h $antllocation ];
	then
		echo "Encountered SymLink : " >> ./jenkins.log
		ant_home=$(readlink -f $antllocation | awk -F/bin/ '{print $1}' | sed 's/\//\\\//g')
	else
		echo "Not a Symlink :" >> ./jenkins.log
		ant_home=$($antllocation | awk -F/bin/ '{print $1}' | sed 's/\//\\\//g')
fi
echo "Setting ANT_HOME $ant_home" >> ./jenkins.log
sed "s/<home>ANT_HOME<\/home>/<home>$ant_home\/<\/home>/g" hudson.tasks.Ant_template.xml >> hudson.tasks.Ant.xml

ipaddr=$(ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
echo "Setting IP $ipaddr" >> ./jenkins.log
jenkins_url_sed=$(echo "http://$ipaddr:8080${jenkins_home_url}" |sed 's/\//\\\//g')
echo "Setting JENKINS_URL : "$jenkins_url_sed >> ./jenkins.log
sed "s/<jenkinsUrl>JENKINS_URL<\/jenkinsUrl>/<jenkinsUrl>$jenkins_url_sed<\/jenkinsUrl>/g" jenkins.model.JenkinsLocationConfiguration_template.xml >> jenkins.model.JenkinsLocationConfiguration.xml

echo "Removing Template Files " >> ./jenkins.log

rm -rf config_template.xml
rm -rf hudson.plugins.git.GitTool_template.xml
rm -rf hudson.tasks.Ant_template.xml
rm -rf hudson.tasks.Maven_template.xml
rm -rf jenkins.model.JenkinsLocationConfiguration_template.xml

echo "Removed Template Files : ">> ./jenkins.log

cd ./..
cp ./Tmplate/* $JENKINS_HOME

echo "Removing Configuration Files " >> ./jenkins.log

rm -rf $compressed_configfile_name
rm -rf ./Tmplate/

echo "Removed Configuration Files " >> ./jenkins.log

echo "Restarting Jenkins " >> ./jenkins.log

java -jar jenkins-cli.jar -s http://localhost:8080$jenkins_home_url restart &

sleep 20

echo "Jenkins Restarted ">> ./jenkins.log

echo "Shell Execution Ended  ">> ./jenkins.log
