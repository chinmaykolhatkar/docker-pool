#!/bin/bash

# Install softwares
apt-get update -y
apt-get -y -o APT::Immediate-Configure=false install wget
wget -O- http://archive.apache.org/dist/bigtop/bigtop-1.1.0/repos/GPG-KEY-bigtop | sudo apt-key add -
wget -O /etc/apt/sources.list.d/bigtop-1.1.0.list http://archive.apache.org/dist/bigtop/bigtop-1.1.0/repos/`lsb_release --codename --short`/bigtop.list

# for openjdk-8-jre-headless
apt-get -y install software-properties-common
add-apt-repository ppa:openjdk-r/ppa
apt-get update -y

apt-get install -y -q --no-install-recommends openjdk-8-jre-headless vim screen curl sudo unzip man openssh-server hadoop\*

wget https://ci.bigtop.apache.org/job/Bigtop-trunk-packages/COMPONENTS=apex,OS=ubuntu-16.04/lastSuccessfulBuild/artifact/output/apex/apex_3.6.0-1_all.deb
dpkg -i apex_3.6.0-1_all.deb
rm apex_3.6.0-1_all.deb

ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64 /usr/lib/jvm/java-openjdk
# Autodetect JAVA_HOME if not defined
. /usr/lib/bigtop-utils/bigtop-detect-javahome

## turn off YARN nodemanager vmem check
sed -i 's#</configuration>##' /etc/hadoop/conf/yarn-site.xml
cat >> /etc/hadoop/conf/yarn-site.xml << EOF
  <property>
    <name>yarn.nodemanager.vmem-check-enabled</name>
    <value>false</value>
  </property>
</configuration>
EOF

## enable WebHDFS and append
sed -i 's#</configuration>##' /etc/hadoop/conf/hdfs-site.xml
cat >> /etc/hadoop/conf/hdfs-site.xml << EOF
  <property>
    <name>dfs.webhdfs.enabled</name>
    <value>true</value>
  </property>
  <property>
    <name>dfs.support.append</name>
    <value>true</value>
  </property>
  <property>
    <name>dfs.support.broken.append</name>
    <value>true</value>
  </property>
  <property>
    <name>dfs.permissions.enabled</name>
    <value>false</value>
  </property>
</configuration>
EOF

## format NameNode
/etc/init.d/hadoop-hdfs-namenode init
## start HDFS
for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do service $i start ; done
## initialize HDFS
/usr/lib/hadoop/libexec/init-hdfs.sh
## stop HDFS
for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do service $i stop ; done
## clean up
apt-get autoclean
rm -rf /var/lib/apt/lists/*
rm -rf /var/log/hadoop-hdfs/*

# Creating user
echo 'root:sc@mb0t' |chpasswd
useradd apex -s /bin/bash -U -G sudo -p apex -m
echo "apex:apex" |chpasswd
echo 'apex ALL=(ALL) NOPASSWD: /etc/init.d/hadoop*' >> /etc/sudoers
echo 'apex ALL=(ALL) NOPASSWD: /etc/init.d/ssh*' >> /etc/sudoers
