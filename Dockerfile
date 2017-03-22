FROM jenkinsci/slave
MAINTAINER Pramod R

ENV JENKINS_REMOTING_VERSION=3.7 \
    JENKINS_HOME=/home/jenkins

RUN curl --create-dirs -sSLo $JENKINS_HOME/remoting/remoting-$JENKINS_REMOTING_VERSION.jar "http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTING_VERSION/remoting-$JENKINS_REMOTING_VERSION.jar" \
  && chmod 755 $JENKINS_HOME/remoting/

COPY ["jenkins-slave.sh", "rmjenkins-slave.sh", "/usr/local/bin/"]
COPY ["addnode.groovy", "rmnode.groovy", "$JENKINS_HOME/groovy_scripts/"]

VOLUME $JENKINS_HOME
