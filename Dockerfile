FROM php:8.2-apache
RUN docker-php-ext-install mysqli pdo_mysql && docker-php-ext-enable mysqli
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
WORKDIR /var/www
COPY . .
RUN chown -R www-data:www-data /var/www
RUN chmod +x start-apache
EXPOSE 80

ARG DB_USER
ARG DB_PASS
ARG DB_NAME
ARG DB_HOST
ARG SITE_URL
ARG SITE_USER
ARG SITE_USER_PASS

ENV DB_USER=$DB_USER
ENV DB_PASS=$DB_PASS
ENV DB_NAME=$DB_NAME
ENV DB_HOST=$DB_HOST
ENV SITE_URL=$SITE_URL
ENV SITE_USER=$SITE_USER
ENV SITE_USER_PASS=$SITE_USER_PASS

CMD ./start-apache