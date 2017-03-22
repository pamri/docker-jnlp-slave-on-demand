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

# Remove docker slave from Jenkins Master
curl --silent --user $JENKINS_USER:$JENKINS_PASSWORD \
--data-urlencode "script=$(<$JENKINS_HOME/groovy_scripts/rmnode.groovy)" \
"$JENKINS_MASTER_URL/script" 2>&1 > /dev/null
echo "Container slave deleted"
