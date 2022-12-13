FROM maven:3.5-jdk-8 AS build  
COPY myapp /myapp
# COPY myapp/pom.xml /usr/src/main
WORKDIR /myapp/
RUN mvn -f pom.xml clean package

FROM gcr.io/distroless/java
ARG var_name
ENV version=${var_name}
COPY --from=build /myapp/target/myapp-${var_name}.jar myapp-${var_name}.jar
EXPOSE 8080  
# CMD [ "ls /user/app/myapp-${version}.jar" ]
ENTRYPOINT ["java","-jar"]
CMD [ "myapp-${var_name}.jar" ]


