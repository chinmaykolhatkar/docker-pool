#!/bin/bash

#Build ubuntu 14.04 docker image
pushd ubuntu
docker build -t chinmayapache/apex:ubuntu-14.04 .
popd
