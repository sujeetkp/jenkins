FROM ubuntu
RUN apt-get update -y && apt-get install -y apache2
RUN echo "Hello from docker" >/var/www/html/index.html
EXPOSE 80
CMD systemctl start apache2 && tail -f /var/log/apache2/access.log
