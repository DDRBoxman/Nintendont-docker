FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y xz-utils mesa-common-dev autotools-dev autoconf automake build-essential libtool libfreeimage-dev

ADD deps /deps

RUN mkdir -p /opt/devkitpro/
RUN tar xf ./deps/devkitppc-amd64_26.tar.xz --strip-components 2 -C /opt/devkitpro/
RUN tar xf ./deps/devkitPPC-r35-1-linux.pkg.tar.xz -C /
RUN tar xf ./deps/devkitARM-r53-1-linux.pkg.tar.xz -C /
RUN tar xf ./deps/libogc-1.8.23-1-any.pkg.tar.xz -C /

WORKDIR /deps/general-tools
RUN ./autogen.sh && ./configure && make && make install

WORKDIR /deps/gamecube-tools
RUN ./autogen.sh && ./configure && make && make install

ENV DEVKITPPC=/opt/devkitpro/devkitPPC
ENV DEVKITARM=/opt/devkitpro/devkitARM
ENV DEVKITPRO=/opt/devkitpro


