FROM java:8-alpine
WORKDIR /code
# 持久化数据目录
#VOLUME /code/data
ADD ./springboot-docker.jar /code/springboot-docker.jar
COPY ./application-docker.yml /code/
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "-Dspring.config.location=/code/application-docker.yml", "/code/springboot-docker.jar"]
