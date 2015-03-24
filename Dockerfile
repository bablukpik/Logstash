#We are using Ubuntu 14.04 as our base image
FROM ubuntu:14.04
MAINTAINER kd <kuldeeparyadotcom@gmail.com>

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV LT_PKG_NAME logstash-1.4.2
#https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz

#Updating apt-get, installing wget, jdk, and jre
RUN apt-get update && apt-get install -y wget default-jre default-jdk


#Install logstash
RUN cd / && wget https://download.elasticsearch.org/logstash/logstash/$LT_PKG_NAME.tar.gz && tar xvzf $LT_PKG_NAME.tar.gz && rm -f $LT_PKG_NAME.tar.gz && mv /$LT_PKG_NAME /logstash 

#Volume for logstash Configuration
VOLUME ["/data"]

#Add Default elasticsearch configuration file
ADD myconfig.conf /data/logstash_config.conf 

#Define working directory
WORKDIR /data

#Define command to run
CMD ["/logstash/bin/logstash","agent","-f","/data/logstash_config.conf"]
