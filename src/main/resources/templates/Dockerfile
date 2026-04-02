# Use official OpenJDK 17 image as base
FROM eclipse-temurin:17-jdk-alpine

# Copy built jar into container
COPY build/libs/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java","-jar","/app.jar"]