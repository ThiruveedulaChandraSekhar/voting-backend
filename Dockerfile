# Stage 1: Build the backend jar
FROM maven:3.9.5-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy only what is needed
COPY pom.xml .
COPY src ./src

# Build the jar
RUN mvn clean package -DskipTests

# Stage 2: Run the backend jar
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

# Expose the port your Spring Boot app uses
EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
