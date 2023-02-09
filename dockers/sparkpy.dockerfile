FROM apache/spark-py
WORKDIR /

USER 0

RUN pip3 install --upgrade PyMySQL && \
    pip3 install --upgrade delta-spark==2.1.0 && \
    pip3 install --upgrade urllib3 && \
    pip3 install --upgrade pandas && \
    rm -rf /root/.cache && rm -rf /var/cache/apt/*

ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar ${SPARK_HOME}/jars/hadoop-aws-3.3.2.jar
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar ${SPARK_HOME}/jars/aws-java-sdk-bundle-1.11.1026.jar
ADD https://repo1.maven.org/maven2/org/wildfly/openssl/wildfly-openssl/1.0.7.Final/wildfly-openssl-1.0.7.Final.jar ${SPARK_HOME}/jars/wildfly-openssl-1.0.7.Final.jar
ADD https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.1.0/delta-core_2.12-2.1.0.jar ${SPARK_HOME}/jars/delta-core_2.12-2.1.0.jar
ADD https://repo1.maven.org/maven2/io/delta/delta-storage/2.1.0/delta-storage-2.1.0.jar ${SPARK_HOME}/jars/delta-storage-2.1.0.jar
RUN chmod 644 ${SPARK_HOME}/jars/hadoop-aws-3.3.2.jar && \
    chmod 644 ${SPARK_HOME}/jars/delta-core_2.12-2.1.0.jar && \
    chmod 644 ${SPARK_HOME}/jars/delta-storage-2.1.0.jar && \
    chmod 644 ${SPARK_HOME}/jars/aws-java-sdk-bundle-1.11.1026.jar && \
    chmod 644 ${SPARK_HOME}/jars/wildfly-openssl-1.0.7.Final.jar

WORKDIR /opt/spark/work-dir
ENTRYPOINT [ "/opt/entrypoint.sh" ]

ARG spark_uid=185
USER ${spark_uid}