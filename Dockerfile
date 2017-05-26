FROM java:8-jre

# install spark
RUN cd /tmp \
 && curl -LO https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz\
 && tar zxf spark-2.1.1-bin-hadoop2.7.tgz \
 && mv spark-2.1.1-bin-hadoop2.7 /app \
 && rm spark-2.1.1-bin-hadoop2.7.tgz

# environment
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
ENV PATH=/app/bin:/app/sbin:$PATH
WORKDIR /app

# entry point
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["idle"]
