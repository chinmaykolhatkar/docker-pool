#### [Apache Apex](http://apex.apache.org/) test sandbox
This repository contains a ready to use [Apache Apex](http://apex.apache.org/) test sandbox docker image in which hadoop and apex is preinstalled and running. All one need to do is launch this docker image and start playing with apex.
#### Basic
##### Run apex docker container
This will create and start a docker container from the docker image.
```
docker run -it --name=apex-sandbox chinmayk/apex:ubuntu-14.04
```
##### Start apex cli after launching docker container
```
apex@f935ef8da5e4:~$ apex
DT CLI 3.4.0 15.03.2016 @ 09:14:48 UTC rev: 374cf9b branch: 374cf9b7431b2268e429d406e422586bea93ae7c
dt> 
```
#### Advanced
##### Linux user information
Username: apex
Password: apex

**NOTE**: User "apex" is added in sudoers list and is privileged with root permissions.

##### Run docker container with host directory mounted
This will create and start a docker container and docker images while mounting local filesystem directory as a mount point inside docker container.
```
docker run -it --name=apex-sandbox -v /local/path/to/mount:/mount/location chinmayk/apex:ubuntu-14.04
```
##### Start already created docker container
```
docker start -i apex-sandbox
```
##### Hadoop and YARN WebUI from local machine
Following command will map yarn and hadoop ports exposed inside docker container to be mapped to ports of host machine.
```
docker run -it --name=apex-sandbox -p 50070:50070 -p 8088:8088 chinmayk/apex:ubuntu-14.04
```
After docker has started, one can point host machine's browser to *localhost:50070* and *localhost:8088* to see hadoop and yarn WebUI respectively.
