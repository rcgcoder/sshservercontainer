FROM ubuntu:latest
MAINTAINER rcgcoder
EXPOSE 2222 
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
#RUN apt-get -y upgrade 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install mc apt-utils sudo dialog openssh-server tzdata 
#RUN apt-get -y install lxde
#RUN apt-get install -y openbox obconf obmenu xterm

COPY addUserWithPassword /usr/bin/addUserWithPassword
RUN chmod 777 -R /usr/bin/addUserWithPassword
COPY runcontainer_sshserver /usr/bin/runcontainer_sshserver
RUN chmod 777 -R /usr/bin/runcontainer_sshserver
COPY containersshserver-setup.sh /usr/bin/containersshserver-setup.sh
RUN chmod 777 -R /usr/bin/containersshserver-setup.sh

ENTRYPOINT ["/bin/bash", "-c", "/usr/bin/runcontainer_sshserver"]