# pentaho-server-docker
参考官网的设置：<br/>
[pentaho server 按照教程](https://help.pentaho.com/Documentation/9.0/Setup/Archive_installation)
<br/>
[pentaho server 配置设置](https://help.pentaho.com/Documentation/9.0/Setup/Customize_the_Pentaho_Server)

<br/>
简单dockerfile：<br/>

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
使用方法：
#创建卷轴<br>

`docker volume create pentaho-server-data`  

<br>   
#创建一个卷轴的pentaho的拷贝，便于自己根据官网配置设置。<br>

`docker run --rm -v pentaho-server-data:/pentaho-server quarrierzhang/pentaho-server:9.0 /bin/bash`    
<br>

#到卷轴的文件夹下 按照官网的设置  配置好 pgsql存储和 tomcat等pgsql的驱动即可 <br/>

#重新运行即可： <br/>
`docker run -d --name pentahoserver -v pentaho-server-data:/pentaho-server -p 8080:8080 quarrierzhang/pentaho-server:9.0`

推送两边





