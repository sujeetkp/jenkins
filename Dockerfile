FROM ubuntu
RUN apt-get update -y && apt-get install -y apache2
RUN echo "Hello all from docker Dev Branch" >/var/www/html/index.html
EXPOSE 80
CMD ["apachectl","-DFOREGROUND"]
