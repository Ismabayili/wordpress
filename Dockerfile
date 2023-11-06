FROM wordpress:latest
#LABEL maintainer="votre-email@example.com"
COPY wp-config.php /var/www/html/wp-config.php
EXPOSE 81
CMD ["apache2-foreground"]
