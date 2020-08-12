FROM ubuntu:18.04
MAINTAINER quarrier <quarriermarje@gmail.com>
ADD ./jdk /usr/local/openjdk-8
COPY ./pentaho-server-ce-9.0.0.0-423.zip /pentaho-server/
ENV JAVA_HOME /usr/local/openjdk-8
ENV JAVA_BIN=$JAVA_HOME/bin \
	JRE_HOME=$JAVA_HOME/jre \
	CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
	PENTAHO_JAVA_HOME=$JAVA_HOME \
	_PENTAHO_JAVA_HOME=$JAVA_HOME \
	PENTAHO_HOME=/pentaho-server	
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
echo 'deb http://mirrors.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse'> /etc/apt/sources.list && \
echo 'deb http://mirrors.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.huaweicloud.com/ubuntu/ bionic-proposed main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.huaweicloud.com/ubuntu/ bionic-proposed main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse'>> /etc/apt/sources.list && \
echo 'deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse'>> /etc/apt/sources.list

RUN apt-get update && apt-get -y install libwebkitgtk-1.0-0 vim ca-certificates openssl zip

WORKDIR $PENTAHO_HOME
RUN unzip ./pentaho-server-ce-9.0.0.0-423.zip -d /pentaho-server/ \
	&& mv ./pentaho-server/** ./ \
	&& rm -rf ./pentaho-server \
	&& rm -rf ./pentaho-server-ce-9.0.0.0-423.zip \
	&& chmod 777 /pentaho-server \
    && chmod -R 777 /pentaho-server/ \
	&& chmod 777 /usr/local/openjdk-8 \
    && chmod -R 777 /usr/local/openjdk-8/ \
	&& rm "/pentaho-server/promptuser.sh" \
	&& echo "tail -f /dev/null" >> /pentaho-server/start-pentaho.sh
COPY ./context.xml /pentaho-server/tomcat/webapps/pentaho/META-INF/
COPY ./repository.xml /pentaho-server/pentaho-solutions/system/jackrabbit/
EXPOSE 8080
CMD ["./start-pentaho.sh"]