FROM ubuntu:20.04

RUN apt-get update

RUN apt-get install -y wget curl software-properties-common gnupg2 winbind xvfb

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype

RUN dpkg --add-architecture i386
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
RUN apt-get update
RUN apt-get install -y winehq-stable

RUN mkdir /root/scpcb/
RUN mkdir /root/tmp/
RUN mkdir /root/tmp/scpcb/
RUN mkdir /root/scpcb/steamcmd

RUN apt-get install -y winetricks
RUN apt-get clean -y

RUN rm -rf /var/lib/apt/lists/*

ENV WINEDEBUG=fixme-all
ENV WINEARCH=win64
ENV WINEPREFIX=/root/.wine64

RUN winetricks msxml6


COPY etc/asound.conf /etc/asound.conf
COPY docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod 755 /root/docker-entrypoint.sh

EXPOSE 50021

WORKDIR /root/scpcb/

CMD ["/root/docker-entrypoint.sh"]