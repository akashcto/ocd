#!/bin/bash
. /config.sh
cd /opt
curl -o nexus.tar.gz  $URL_Nexus
tar -xvzf nexus.tar.gz
rm -rf nexus.tar.gz
cd ../
useradd --user-group --system --home-dir /opt/sonatype-nexus nexus
chown -R nexus:nexus /opt/sonatype-work /opt/sonatype-nexus
export NEXUS_WEBAPP_CONTEXT_PATH=/nexus
cd /
touch start.sh
echo "cd /opt" >> start.sh
echo "sh start_as_nexus.sh" >> start.sh
