# -------------------------
# Stage 1: Build stage
# -------------------------
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom.xml first to leverage Docker layer caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests



# -------------------------
# Stage 2: Runtime stage
# -------------------------
#FROM eclipse-temurin:21-jre-alpine
FROM gcr.io/distroless/java21-debian12

WORKDIR /app

# Copy only the jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 9090

# Run Spring Boot app
ENTRYPOINT ["java","-jar","app.jar"]
