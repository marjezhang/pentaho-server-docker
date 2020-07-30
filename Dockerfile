FROM openjdk:8u252
MAINTAINER quarrier <quarriermarje@gmail.com>
COPY ./pentaho-server /pentaho-server
ENV JAVA_BIN=$JAVA_HOME/bin \
	JRE_HOME=$JAVA_HOME/jre \
	CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
	PENTAHO_JAVA_HOME=$JAVA_HOME \
	_PENTAHO_JAVA_HOME=$JAVA_HOME \
	PENTAHO_HOME=/pentaho-server	
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
RUN chmod 777 /pentaho-server \
    && chmod 777 /pentaho-server/** \
    && echo "tail -f /dev/null" >> /pentaho-server/start-pentaho.sh
EXPOSE 8080
WORKDIR $PENTAHO_HOME
CMD ["/pentaho-server/start-pentaho.sh"]