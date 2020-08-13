# pentaho-server-docker
�ο����������ã�<br/>
[pentaho server ���ս̳�](https://help.pentaho.com/Documentation/9.0/Setup/Archive_installation)
<br/>
[pentaho server ��������](https://help.pentaho.com/Documentation/9.0/Setup/Customize_the_Pentaho_Server)

<br/>
��dockerfile��<br/>

```dockerfile
FROM openjdk:8u252
MAINTAINER quarrier <quarriermarje@gmail.com>
COPY ./pentaho-server /pentaho-server
ENV JAVA_BIN $JAVA_HOME/bin
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PENTAHO_JAVA_HOME $JAVA_HOME
ENV _PENTAHO_JAVA_HOME $JAVA_HOME
ENV PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
RUN chmod 777 /pentaho-server \
    && chmod 777 /pentaho-server/** \
    && echo "tail -f /dev/null" >> /pentaho-server/start-pentaho.sh
EXPOSE 8080
CMD ["/pentaho-server/start-pentaho.sh"]
```

<br/>
ʹ�÷�����
#��������<br>

`docker volume create pentaho-server-data`  

<br>   
#����һ�������pentaho�Ŀ����������Լ����ݹ����������á�<br>

`docker run --rm -v pentaho-server-data:/pentaho-server quarrierzhang/pentaho-server:9.0 /bin/bash`    
<br>

#��������ļ����� ���չ���������  ���ú� pgsql�洢�� tomcat��pgsql���������� <br/>

#�������м��ɣ� <br/>
`docker run -d --name pentahoserver -v pentaho-server-data:/pentaho-server -p 8080:8080 quarrierzhang/pentaho-server:9.0`

��������





