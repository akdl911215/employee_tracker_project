FROM openjdk:17-jdk-slim

WORKDIR /app

COPY build/libs/kotlin-test-0.0.1-SNAPSHOT.jar app.jar

COPY package*.json ./

ENV DATABASE_URL=postgresql://postgres:123456@43.203.208.39:5432/postgres
ENV PORT=8080
ENV HOST=43.203.208.39

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]