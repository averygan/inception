FROM debian:bullseye

RUN apt-get update && \
  apt-get install -y \
    php-fpm \
    php-cgi \
    php-mysql \
    php-pdo \
    php-gd \
    php-cli \
    php-mbstring \
    wget \
    mariadb-client \
    unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html /run/php

RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && \
  unzip /tmp/wordpress.zip -d /tmp && \
  mv /tmp/wordpress/* /var/www/html && \
  rm /tmp/wordpress.zip

RUN chown -R www-data:www-data /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY tools/init_wordpress.sh /usr/local/bin/init_wordpress.sh
RUN chmod +x /usr/local/bin/init_wordpress.sh
ENTRYPOINT ["sh", "/usr/local/bin/init_wordpress.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]