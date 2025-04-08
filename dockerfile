# Build stage
FROM maven:3.9.4-eclipse-temurin-17-focal as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Final stage
FROM tomcat:jdk21-openjdk-slim
COPY --from=build /app/target/payroll.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]