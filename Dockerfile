FROM ubuntu:latest
MAINTAINER rcgcoder
EXPOSE 22


ARG withUser=sae
ARG withPassword=sae

ARG TimeZone=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive

RUN ln -snf $(echo "/usr/share/zoneinfo/$TimeZone") /etc/localtime && echo "$TimeZone" > /etc/timezone
RUN apt-get update
#RUN apt-get -y upgrade 
RUN apt-get -y install mc apt-utils sudo dialog openssh-server tzdata 
#RUN apt-get -y install lxde
#RUN apt-get install -y openbox obconf obmenu xterm

COPY addUserWithPassword /usr/bin/addUserWithPassword
RUN chmod 777 -R /usr/bin/addUserWithPassword
COPY runcontainer_sshserver /usr/bin/runcontainer_sshserver
RUN chmod 777 -R /usr/bin/runcontainer_sshserver
COPY containersshserver-setup.sh /usr/bin/containersshserver-setup.sh
RUN chmod 777 -R /usr/bin/containersshserver-setup.sh
COPY bootstrap.sh /usr/bin/bootstrap.sh
RUN chmod 777 -R /usr/bin/bootstrap.sh

ENTRYPOINT ["/bin/bash", "-c", "/usr/bin/runcontainer_sshserver"]