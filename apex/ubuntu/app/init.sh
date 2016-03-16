#!/bin/bash
. /lib/lsb/init-functions

set -e

log_daemon_msg "Starting hadoop services... This might take few seconds..."
sudo /etc/init.d/hadoop-hdfs-namenode restart \
  && sudo /etc/init.d/hadoop-hdfs-datanode restart \
  && sudo /etc/init.d/hadoop-yarn-resourcemanager restart \
  && sudo /etc/init.d/hadoop-yarn-nodemanager restart \
  && sudo /etc/init.d/hadoop-yarn-timelineserver restart
log_end_msg $?

echo
echo "====================================="
echo " Welcome to Apache Apex docker image "
echo "====================================="
echo "This docker image uses bigtop package of hadoop and apex."
echo "This image provides a ready to use environment for quickly launching apex application."
echo "Currently running docker container has hadoop services initialized and started."
echo "Just type \"apex\" on command line to get apex cli console. See man page of apex for details."
echo "Enjoy Apexing!!!"

/bin/bash
