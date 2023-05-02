FROM ubuntu:20.04
MAINTAINER dreamcmi

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Shanghai

COPY ./cvi_mmf_sdk /root/cvi_mmf_sdk
COPY ./host-tools /root/host-tools
COPY ./genimage /root/genimage
COPY ./cmake-3.26.3.tar.gz /root

RUN echo 'Asia/Shanghai' >/etc/timezone
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt update && \
    apt install -y \
    automake \
    autoconf \
    libtool \
    slib \
    squashfs-tools \
    dialog \
    python3 \
    python3-dev \
    make \
    git \
    wget \
    curl \
    bc \
    gcc \
    g++ \
    flex \
    bison \
    ninja-build \
    libssl-dev \
    rsync \
    pkg-config \
    device-tree-compiler \
    squashfs-tools \
    parted \
    dosfstools \
    cpio \
    libncurses-dev \
    texinfo \
    genext2fs \
    mtools \
    libconfuse-dev \
    zip

RUN cd /root && \
    tar -xzvf cmake-3.26.3.tar.gz && \
    cd cmake-3.26.3 && \
    ./configure && make -j$(nproc) && \
    make install

RUN cd /root/genimage && \
    ./autogen.sh && \
    ./configure && \
    make -j$(nproc) && \
    make install
