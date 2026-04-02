# ==========================
# Stage 1: Build the JAR
# ==========================
FROM gradle:7.6.1-jdk17-alpine AS builder

# Set working directory
WORKDIR /home/gradle/project

# Copy project files
COPY . .

# Make Gradle wrapper executable
RUN chmod +x ./gradlew

# Clean and build the Spring Boot JAR
RUN ./gradlew clean bootJar --no-daemon

# ==========================
# Stage 2: Run the JAR
# ==========================
FROM eclipse-temurin:17-jdk-alpine

# Set working directory inside runtime container
WORKDIR /app

# Copy the jar from builder stage
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]