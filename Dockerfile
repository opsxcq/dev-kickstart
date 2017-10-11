FROM debian:jessie

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    qemu qemu-kvm qemu-system-x86 qemu-system \
    libvirt-bin libvirt-clients virtinst \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 5900

VOLUME /iso

VOLUME /src
WORKDIR /src

COPY main.sh /
ENTRYPOINT ["/main.sh"]
