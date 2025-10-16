# Stage 1: build the app
FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: run the app
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/student-management-0.0.1-SNAPSHOT.jar student.jar
EXPOSE 8089
ENTRYPOINT ["java", "-jar", "student.jar"]