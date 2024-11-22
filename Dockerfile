FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    docker.io

RUN usermod -aG docker jenkins

# Set correct permissions
RUN mkdir -p /var/jenkins_home/caches && \
    chown -R jenkins:jenkins /var/jenkins_home && \
    chmod -R 777 /var/jenkins_home

EXPOSE 8080
EXPOSE 50000

VOLUME /var/jenkins_home

USER jenkins
