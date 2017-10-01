FROM ubuntu:16.04

RUN mkdir /opt/AIL && apt-get update -y \
	&& apt-get install git python-dev build-essential \
	libffi-dev libssl-dev libfuzzy-dev wget sudo -y

# Adding sudo command
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#USER docker
ADD . /opt/AIL
WORKDIR /opt/AIL
RUN ./installing_deps.sh 
WORKDIR /opt/AIL/var/www
RUN ./update_thirdparty.sh

WORKDIR /opt/AIL

CMD bash docker_start.sh
