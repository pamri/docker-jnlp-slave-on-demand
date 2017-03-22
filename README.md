# Jenkins On Demand JNLP Slave Docker image

## Description

This is a Docker image for setting up a Jenkins slave agent based on JNLP. The idea for this image came from [docker-jnlp-slave](https://github.com/jenkinsci/docker-jnlp-slave), but is a complete rewrite.

Using this image, you can add the Jenkins slave container to the Master, connect to the Master and then delete itself. Currently, node names are hard-coded in the groovy script, but will be fixed in future updates.

## Running

### As an interactive shell
```
docker run -e JENKINS_MASTER_URL='http://jenkins_master_host:jenkins_port/jenkins_url' \
-e JENKINS_USER='adminuser' \
-e JENKINS_PASSWORD='adminpassword' \
-it docker-jnlp-slave-on-demand /bin/bash
```
You can then run _jenkins-slave.sh_ and _rmjenkins-slave.sh_ manually

### Add and connect to Jenkins Master
```
docker run -e JENKINS_MASTER_URL='http://jenkins_master_host:jenkins_port/jenkins_url' \
-e JENKINS_USER='adminuser' \
-e JENKINS_PASSWORD='adminpassword' \
-it docker-jnlp-slave-on-demand /usr/local/bin/jenkins-slave.sh
```

### Delete from Jenkins Jenkins Master
```
docker run -e JENKINS_MASTER_URL='http://jenkins_master_host:jenkins_port/jenkins_url' \
-e JENKINS_USER='adminuser' \
-e JENKINS_PASSWORD='adminpassword' \
-it docker-jnlp-slave-on-demand /usr/local/bin/rmjenkins-slave.sh
```
