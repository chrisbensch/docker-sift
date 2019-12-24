FROM ubuntu:16.04
MAINTAINER Chris Bensch - https://github.com/chrisbensch/sifter

ARG DEBIAN_FRONTEND=noninteractive

ENV SUDO_USER root

#ADD ./scripts /scripts

RUN apt-get clean && apt-get update

RUN apt-get install -y  wget bash gnupg2 sudo

RUN wget --quiet https://github.com/teamdfir/sift-cli/releases/download/v1.8.0/sift-cli-linux

RUN gpg2 --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 22598A94

RUN mv sift-cli-linux /usr/local/bin/sift

RUN chmod 755 /usr/local/bin/sift

RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/sifter --gecos "SIFT User" sifter

RUN echo "sifter:password" | chpasswd

RUN sudo sift install --mode=server --user=sifter --verbose

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/sh"]


