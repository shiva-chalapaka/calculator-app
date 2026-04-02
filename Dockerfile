# Stage 1: Build
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy pom first to leverage Docker cache
COPY pom.xml .

# Download dependencies (offline mode)
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Package the jar without compiling or running tests
RUN mvn clean package -Dmaven.test.skip=true

# Stage 2: Runtime image
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Command to run the app
ENTRYPOINT ["java","-jar","app.jar"]