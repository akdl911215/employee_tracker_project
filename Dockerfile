FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY build/libs/EmployeeTrackerProject-1.0-SNAPSHOT.jar app.jar

COPY package*.json ./

ENV DATABASE_URL=postgresql://postgres:123456@3.35.50.208:5432/postgres
ENV PORT=8080
ENV HOST=3.35.50.208

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]