FROM ubuntu
RUN apt-get update -y && apt-get install -y apache2
RUN echo "35Hiiii all from docker Dev Branch new21" >/var/www/html/index.html
EXPOSE 80
CMD ["apachectl","-DFOREGROUND"]
