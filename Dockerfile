FROM ubuntu
RUN apt-get update -y && apt-get install -y apache2
RUN echo "hello Hiiii all from docker from Master new678" >/var/www/html/index.html
EXPOSE 80
CMD ["apachectl","-DFOREGROUND"]
