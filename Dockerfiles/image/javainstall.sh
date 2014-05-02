#!/bin/bash
. /config.sh
curl -o jdk.tar.gz $URL_JDK
cd /usr/local/
mkdir java
cd ../../
cp -r -f jdk.tar.gz /usr/local/java/
cd /usr/local/java/
mkdir jdk/
tar --strip-components=1 -zxvf jdk.tar.gz -C jdk/
rm -rf  jdk.tar.gz
cd ../../../
rm -rf  jdk.tar.gz
echo "export JAVA_HOME=/usr/local/java/jdk" >> /etc/profile
echo "export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> /etc/profile
echo "export JRE_HOME=/usr/local/java/jdk/jre" >> /etc/profile
echo "export PATH=$PATH:$HOME/bin:$JRE_HOME/bin" >> /etc/profile
update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk/jre/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk/bin/javac" 1
update-alternatives --set java /usr/local/java/jdk/jre/bin/java
update-alternatives --set javac /usr/local/java/jdk/bin/javac
. /etc/profile
