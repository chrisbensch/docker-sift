FROM ubuntu:20.04

LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV SUDO_USER root

RUN apt update && apt -y upgrade \ 
  && apt -y --no-install-recommends install wget bash gnupg2 sudo \ 
  && wget --quiet https://github.com/teamdfir/sift-cli/releases/download/v1.13.1/sift-cli-linux \
  && mv sift-cli-linux /usr/local/bin/sift \ 
  && chmod 755 /usr/local/bin/sift \ 
  && adduser --quiet --disabled-password --shell /bin/bash --home /home/sift --gecos "SIFT Analyst" sift \ 
  && echo "sift:password" | chpasswd && \
  apt -y autoremove && \
  apt -y autoclean && \
  rm -rf /var/lib/apt/lists/*

RUN sudo sift install --mode=server --user=sift --verbose

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/bash"]
