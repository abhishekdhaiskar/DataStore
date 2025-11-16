# =========================
#   STAGE 1 — BUILD
# =========================
FROM amazoncorretto:11-alpine-jdk AS builder

# Set working directory
WORKDIR /app

# Copy everything (including mvnw)
COPY . .

# Make mvnw executable
RUN chmod +x mvnw

# Build the application (skip tests to speed up Jenkins)
RUN ./mvnw clean package -DskipTests


# =========================
#   STAGE 2 — RUNTIME
# =========================
FROM amazoncorretto:11-alpine-jdk

# Set working directory
WORKDIR /app

# Copy jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose app port
EXPOSE 8081

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
