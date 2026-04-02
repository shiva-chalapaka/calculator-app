# Use official Gradle image to build the app
FROM gradle:7.6.1-jdk17-alpine AS builder

WORKDIR /home/gradle/project

# Copy only necessary files for build
COPY build.gradle settings.gradle ./
COPY src ./src

# Build the app jar
RUN gradle clean bootJar --no-daemon

# Use lightweight OpenJDK runtime image
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy the jar from the builder stage
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]