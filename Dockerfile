FROM maven as build_server
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat
COPY --from=build_server /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
