FROM nvcr.io/nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

ADD sources.list /etc/apt/sources.list
RUN apt update && apt upgrade -y && apt install -y apt-utils build-essential ca-certificates \
	curl wget vim net-tools openssh-server ffmpeg libsm6 libxext6
ADD vimrc /root/.vimrc
ADD pip.conf /root/.pip/pip.conf
ADD condarc /root/.condarc

ADD Miniconda3-latest-Linux-x86_64.sh /root/miniconda3/miniconda_install.sh
RUN bash /root/miniconda3/miniconda_install.sh -b -u -p /root/miniconda3
RUN /root/miniconda3/bin/conda init bash
RUN /root/miniconda3/bin/conda install -y -c tartansandal conda-bash-completion
RUN rm -f /root/miniconda3/miniconda_install.sh

COPY go1.22.4.linux-amd64.tar.gz go1.22.4.linux-amd64.tar.gz
RUN  rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz
RUN rm -f go1.22.4.linux-amd64.tar.gz

RUN mkdir /var/run/sshd
RUN echo "root:lm@2024" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's@session    required     pam_loginuid.so@session    optional     pam_loginuid.so@g' /etc/pam.d/sshd
EXPOSE 22

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git tzdata locales
RUN ln -sf /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime && \
    echo "Asia/Hong_Kong" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

RUN mkdir -p /root/.ssh && touch /root/.ssh/id_ed25519 && touch /root/.ssh/id_ed25519.pub
COPY bashrc_plus bashrc_plus
RUN cat bashrc_plus >> /root/.bashrc
RUN rm -f bashrc_plus

RUN echo 'Welcome to the Gangsta Server! Stay cool, amigo! 😎' > /etc/motd && \
    chmod -x /etc/update-motd.d/*

RUN apt update && apt install -y protobuf-compiler

WORKDIR /root
