#!/bin/bash
. /config.sh
curl -O $URL_JavaFramework
tar zxvf Services_JAVA_DOCKER.tar.gz
rm -rf Services_JAVA_DOCKER.tar.gz
touch start.sh
echo "cd /Services_JAVA_DOCKER/CodeStyle" >> start.sh
echo "curl -O $URL_CodeStyle" >> start.sh
echo "cd /Services_JAVA_DOCKER/JBS" >> start.sh
echo "curl -O $URL_BuildService" >> start.sh
echo "cd /Services_JAVA_DOCKER" >> start.sh
echo "curl -O $URL_GitPlugin" >> start.sh
echo "cd /" >> start.sh
echo 'java -jar /Services_JAVA_DOCKER/GitPlugin-jar-with-dependencies.jar 172.17.42.1 5555 5557 akashcto 27c02b7623c71b2e7cf7593dc9a0f1425c6dc6f9 $RANDOM / /Services_JAVA_DOCKER/log4j.properties 0.0.0.0 5558 172.17.42.1 7050 https://api.github.com/ &' >> start.sh
echo "java -jar /Services_JAVA_DOCKER/CodeStyleCheck/CodestyleService.jar 5566 8899 0.0.0.0 172.17.42.1 /Services_JAVA_DOCKER/CodeStyleCheck/validation_cs.sh 5568 github.com &" >> start.sh
echo "java -jar /Services_JAVA_DOCKER/JBS/JenkinsBuildService-jar-with-dependencies.jar 0.0.0.0 172.17.42.1  7789 3335 5560 172.17.42.1 8080 Seq_1 http://172.17.42.1:8080/ /Services_JAVA_DOCKER/JBS/configFiles/broadleaf/ /Services_JAVA_DOCKER/JBS/configFiles/db/ github.com" >> start.sh
