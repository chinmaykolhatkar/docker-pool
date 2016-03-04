#!/bin/bash

# Install softwares
wget -O- http://archive.apache.org/dist/bigtop/bigtop-1.1.0/repos/GPG-KEY-bigtop | sudo apt-key add -
wget -O /etc/apt/sources.list.d/bigtop-1.1.0.list http://archive.apache.org/dist/bigtop/bigtop-1.1.0/repos/`lsb_release --codename --
apt-get update -y
apt-get install -y git python vim screen maven wget curl sudo unzip hadoop\* firefox x11vncserver


