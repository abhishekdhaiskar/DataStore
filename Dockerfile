# ======= BUILD STAGE =======
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy all project files (must include pom.xml and mvnw)
COPY . .

# Make Maven wrapper executable
RUN chmod +x mvnw

# Build the project and skip tests
RUN ./mvnw clean package -DskipTests

# ======= RUNTIME STAGE =======
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the built jar from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
