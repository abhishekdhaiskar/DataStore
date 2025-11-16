FROM amazoncorretto:11-alpine-jdk as builder

RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source

# Fix permission issue
RUN chmod +x mvnw

RUN ./mvnw package

FROM amazoncorretto:11-alpine-jdk
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
