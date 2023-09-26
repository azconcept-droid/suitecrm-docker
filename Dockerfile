FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# install apache
RUN apt-get update && \
    apt install -y apache2 apache2-utils 

# install php 8.x
RUN apt-get update && \
    apt -y install software-properties-common && \
    add-apt-repository ppa:ondrej/php -y && \
    apt -y install php && \
    php -v

RUN apt install -y php-cli php-common php-curl php-mbstring php-gd php-mysql php-soap php-xml php-imap php-intl php-json php-zip php-bcmath

# suitecrm setup
# COPY ./config.conf /etc/apache2/sites-available/suitecrm.conf
WORKDIR /var/www/html

COPY ./suitecrm ./suitecrm
# RUN chown -R www-data:www-data /var/www/html/suitecrm
RUN chown -R www-data:www-data . && \
    chmod -R 755 . && \
    chmod -R 775 cache custom modules themes data upload

# RUN a2ensite suitecrm.conf
# RUN chmod -R 775 /var/www/html/suitecrm/config_override.php 2>/dev/null
    # service apache2 restart

# expose container at port 80
EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND" ]

# ENTRYPOINT [ "config.sh" ]