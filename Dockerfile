FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/student-enrolment-0.0.1-SNAPSHOT.jar
WORKDIR /opt/app
COPY ${JAR_FILE} student-api.jar
ENTRYPOINT ["java","-jar","student-api.jar"]