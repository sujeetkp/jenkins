FROM ubuntu
RUN apt-get update -y && apt-get install -y apache2
RUN echo "Hello alllll from docker Dev Branch" >/var/www/html/index.html
EXPOSE 80
CMD ["apachectl","-DFOREGROUND"]
