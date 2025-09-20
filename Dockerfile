# Build stage
FROM maven:3.9.5-eclipse-temurin-17 as builder
WORKDIR /app

COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -DskipTests package

# Run stage
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
