#!/bin/bash

if [ -z "$JENKINS_MASTER_URL" ]; then
  if [ -z "$1" ]; then
    echo "JENKINS_MASTER_URL is empty. Rerun the container with the variable set or pass the URL as an argument to this script."
    exit 1
  elif [ -n "$1" ]; then
    JENKINS_MASTER_URL=$1
  fi
fi
if [ -z "$JENKINS_USER" ] && [ -z "$JENKINS_PASSWORD" ]; then
  echo "Missing Credentials. You need to set JENKINS_USER and JENKINS_PASSWORD"
  exit 1
fi
if [ -z "$JENKINS_HOME" ]; then
  echo "Missing Jenkins Home Directory. You need to set JENKINS_HOME"
  exit 1
fi

echo "Jenkins Master : $JENKINS_MASTER_URL"
echo "Jenkins Home : $JENKINS_HOME"

# Add docker slave to Jenkins Master. Get secret token
SECRET="$(curl --silent --user $JENKINS_USER:$JENKINS_PASSWORD \
--data-urlencode "script=$(<$JENKINS_HOME/groovy_scripts/addnode.groovy)" \
"$JENKINS_MASTER_URL/script" | grep 'Secret Key for container-node' | cut -f2 -d:)"
# SLAVE_NAME is hard-coded for now. Need to update groovy script if changed here.
SLAVE_NAME="container-node"

# jenkins remoting jar
JAR=`ls -1 $JENKINS_HOME/remoting/remoting-*.jar | tail -n 1`

echo Running java $JAVA_OPTS -cp $JAR hudson.remoting.jnlp.Main -headless -url $JENKINS_MASTER_URL $SECRET $SLAVE_NAME
exec java $JAVA_OPTS -cp $JAR hudson.remoting.jnlp.Main -headless -url $JENKINS_MASTER_URL $SECRET $SLAVE_NAME
