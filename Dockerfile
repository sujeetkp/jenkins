FROM ubuntu
RUN apt-get update -y && apt-get install -y apache2
RUN echo " Heloo Hiiii all from docker from Master" >/var/www/html/index.html
EXPOSE 80
CMD ["apachectl","-DFOREGROUND"]
