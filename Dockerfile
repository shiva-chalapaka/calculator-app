# Use non-alpine Gradle image for better compatibility
FROM gradle:7.6.1-jdk17 AS builder

WORKDIR /home/gradle/project

COPY build.gradle settings.gradle ./
COPY src ./src

# Clear Gradle cache to avoid corrupt jars, then build
RUN rm -rf /home/gradle/.gradle/caches/*
RUN gradle clean bootJar --no-daemon

FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]