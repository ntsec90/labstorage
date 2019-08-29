#!/bin/bash

## RUN NSM ENGINE ###
string="Start Create & Run NSM"
echo $string

## Delete folder & file exists
rm -f /var/run/nsm/
rm -R /var/log/nsm/
rm -f /var/run/nsm.fifo
rm -R /var/nsm/ipc/
rm -R /var/nsm/*
rm -f /var/nsm/*.*
userdel nsm

## Mkdir folder log for nsm
cd /root
mkdir /var/run/nsm
mkdir /var/log/nsm

## Create account & permission
sudo useradd nsm --shell /sbin/nologin --home /
sudo chown -R nsm:nsm /var/log/nsm
sudo chown -R nsm:nsm /var/run/nsm  
chown -R nsm:nsm /var/log/nsm /var/run/nsm
chown -R nsm:nsm /usr/local/etc/

## Mkdir file fifo nsm & permission
mkfifo /var/run/nsm.fifo
chown nsm:nsm /var/run/nsm.fifo
chmod 666 /var/run/nsm.fifo /var/log/*
chmod ugo+x /var/log/nsm
chmod 0600 /var/log/btmp

## Create IPC folder
mkdir /var/nsm
mkdir /var/nsm/ipc/
cd /var/nsm/ipc/
touch nsm-counters.shared 
touch thresh-by-source.shared
touch thresh-by-destination.shared 
chown nsm:nsm  /var/nsm/ipc/
chmod -R 777 /var/nsm/ipc/
chmod -R 777 /var/nsm/ipc/*
chmod -R 777 /var/nsm/ipc/*.*
chmod 666 /var/nsm/ipc/
chmod ugo+x /var/nsm/ipc/

## RUN NSMTV 
cd /root/NSMTV/
nsm -f /usr/local/etc/nsm.yaml