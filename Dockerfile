FROM jenkins/jenkins:lts


USER root


RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

USER jenkins

EXPOSE 8080
EXPOSE 50000

VOLUME /var/jenkins_home
