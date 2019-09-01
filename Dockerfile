FROM java:8-alpine
WORKDIR /code
# 持久化数据目录
#VOLUME /code/data
ADD ./target/springboot-docker.jar /code/springboot-docker.jar
COPY ./src/main/resources/application.yml /code/
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "-Dspring.config.location=/code/application.yml", "/code/springboot-docker.jar"]
