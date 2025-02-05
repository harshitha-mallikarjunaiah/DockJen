FROM tomcat:9-jre9
COPY ./target/DockJen.war /usr/local/tomcat/webapps/
