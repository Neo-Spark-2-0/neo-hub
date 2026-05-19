FROM maven:3.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:11.0-jdk25
COPY --from=build /app/target/neohub.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080