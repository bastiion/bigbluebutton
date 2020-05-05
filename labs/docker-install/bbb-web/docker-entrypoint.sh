#!/usr/bin/env bash

set -a

mkdir -p /var/bigbluebutton/recording/raw
mkdir -p /var/bigbluebutton/recording/process
mkdir -p /var/bigbluebutton/recording/publish
mkdir -p /var/bigbluebutton/recording/status/recorded
mkdir -p /var/bigbluebutton/recording/status/archived
mkdir -p /var/bigbluebutton/recording/status/processed
mkdir -p /var/bigbluebutton/recording/status/sanity
mkdir -p /var/bigbluebutton/published
mkdir -p /var/bigbluebutton/deleted
mkdir -p /var/bigbluebutton/unpublished

JAVA_HOME="/usr/lib/jvm/default-java"
source "/etc/default/tomcat7"
CATALINA_HOME="/usr/share/tomcat7"
CATALINA_BASE="/var/lib/tomcat7"
JAVA_OPTS="-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC"
CATALINA_PID="/var/run/tomcat7.pid"
CATALINA_TMPDIR="/tmp/tomcat7-tomcat7-tmp"
LANG="en_US.utf8"
JSSE_HOME="/usr/lib/jvm/default-java/jre/"
JAVA_OPTS="${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -DsecuritySalt=${SHARED_SECRET} -Dredis.host=redis -DredisHost=redis -Dbigbluebutton.web.serverURL=https://${SERVER_DOMAIN} -DattendeesJoinViaHTML5Client=true -DmoderatorsJoinViaHTML5Client=true -DsvgImagesRequired=true"
sed -i "s|^securerandom\.source=.*|securerandom.source=file:/dev/urandom|g" ${JAVA_HOME}/lib/security/java.security

cd "/var/lib/tomcat7"
/usr/share/tomcat7/bin/catalina.sh run
