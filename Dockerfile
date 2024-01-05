FROM ubuntu:22.04

LABEL maintainer="chris.bensch@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y upgrade && \ 
  apt -y install \
    wget \
    curl \
    git \
    bash \
    gnupg2 \
    zsh \
    xz-utils \
    sudo && \
  wget -O cast.deb https://github.com/ekristen/cast/releases/download/v0.14.0/cast_v0.14.0_linux_amd64.deb && \
  dpkg -i cast.deb && \
  rm cast.deb && \
  adduser --quiet --disabled-password --shell /bin/zsh --home /home/sift --gecos "SIFT Analyst" sift && \
  echo "sift:password" | chpasswd && \
  usermod -aG sudo sift && \
  apt -y autoremove && \
  apt -y autoclean && \
  rm -rf /var/lib/apt/lists/* && \
  cast install --mode=server --user=sift teamdfir/sift-saltstack && \
  apt -y remove --purge cast

USER sift
WORKDIR /home/sift
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc && \
  wget https://github.com/romkatv/gitstatus/releases/download/v1.5.4/gitstatusd-linux-x86_64.tar.gz && \
  tar zxf gitstatusd-linux-x86_64.tar.gz && \
  mkdir -p /home/sift/.cache/gitstatus && \
  mv gitstatusd-linux-x86_64 /home/sift/.cache/gitstatus/gitstatusd-linux-x86_64

COPY zshrc /home/sift/.zshrc
COPY p10k.zsh /home/sift/.p10k.zsh
VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/zsh"]
