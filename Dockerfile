# FROM openjdk:latest
# WORKDIR /app
# COPY . .
# EXPOSE 8080
# CMD ["java", "-jar", "app.jar"]

FROM maven:latest AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
FROM openjdk:latest
WORKDIR /app
COPY --from=build /app/target/maven-web-application.war ./myapp.war 
EXPOSE 8078
CMD ["java", "-jar", "myapp.war"]

