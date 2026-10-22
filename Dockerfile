# Same Java 11 / Tomcat 9 runtime as the laboratory.
FROM tomcat:9.0-jdk11-corretto
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager
COPY attendance.war /usr/local/tomcat/webapps/attendance.war
# The assignment requires the root service URL to work as well.
COPY deploy-root/index.html /usr/local/tomcat/webapps/ROOT/index.html
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh
RUN chmod +x /usr/local/tomcat/bin/entrypoint.sh
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/entrypoint.sh"]
