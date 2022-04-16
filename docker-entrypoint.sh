#!/usr/bin/env bash

sleep 1s

server_dir=scpcb
server_executable=server.exe

mkdir -p ~/.local/bin ~/.config ~/.cache
mkdir -p /root/$server_dir/steamcmd
echo -e 'pcm.!default {\n type plug\n slave.pcm "null"\n}' > /root/.asoundrc


# Download SteamCmd
cd /root/$server_dir/steamcmd/ && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
cd /root/$server_dir/


# download DedicatedServer
/root/$server_dir/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +login anonymous +force_install_dir /root/$server_dir +app_update 1801280 +exit


# cleanup old log and create empty new
[ -f /root/$server_dir/server_log.txt ] && rm -v /root/$server_dir/server_log.txt || touch /root/$server_dir/server_log.txt
touch /root/$server_dir/server_log.txt


# Run Server in xvfb Virtual screen
xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine /root/$server_dir/$server_executable -log &

# output latest log
tail -f /root/$server_dir/server_log.txt