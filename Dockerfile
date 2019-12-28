FROM ubuntu:16.04

LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ENV SUDO_USER root

RUN apt-get clean && apt-get update \ 
&& apt-get install -y wget bash gnupg2 sudo \ 
&& wget --quiet https://github.com/teamdfir/sift-cli/releases/download/v1.8.0/sift-cli-linux \
&& gpg2 --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 22598A94 \ 
&& mv sift-cli-linux /usr/local/bin/sift \ 
&& chmod 755 /usr/local/bin/sift \ 
&& adduser --quiet --disabled-password --shell /bin/bash --home /home/sift --gecos "SIFT User" sift \ 
&& echo "sift:password" | chpasswd \ 
&& sudo sift install --mode=server --user=sift --verbose

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/bash"]
