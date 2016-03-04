# How to run this script from same folder:
# docker build .

FROM ubuntu:14.04
MAINTAINER Chinmay Kolhatkar <chinmay@apache.org>

COPY app/ /app/
RUN /app/setup.sh

USER apex
WORKDIR /home/apex

ENTRYPOINT ["/app/init.sh"]
