# ======= BUILD STAGE =======
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy everything from repo root (must include pom.xml and mvnw)
COPY . .

# Make mvnw executable
RUN chmod +x mvnw

# Build project, skip tests
RUN ./mvnw clean package -DskipTests

# ======= RUNTIME STAGE =======
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built jar from builder
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
