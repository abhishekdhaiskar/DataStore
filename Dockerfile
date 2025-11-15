# ======= BUILD STAGE =======
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy the project
COPY . .

# Make mvnw executable
RUN chmod +x mvnw

# Build the project, skip tests
RUN ./mvnw clean package -DskipTests

# ======= RUNTIME STAGE =======
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose default port (optional)
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
