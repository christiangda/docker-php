ARG ALPINE_VERSION=3.7
FROM alpine:${ALPINE_VERSION}

ARG PHP_VERSION
ARG APACHE_VERSION

# Environment variables
ENV PHP_VERSION=${PHP_VERSION:-7.1.12-r0} \
    APACHE_VERSION=${APACHE_VERSION:-2.4.29-r1} \
    APACHE_PORT=80 \
    APACHE_HOME_ROOT="/var/www" \
    APACHE_APP_ROOT="/var/www/html" \
    APACHE_USER="apache" \
    APACHE_GROUP="apache"

# Container's Labels
LABEL maintainer="Christian González Di Antonio <christiangda@gmail.com>, Elías Moreno <elias.moreno.tec@gmail.com>" \
      org.opencontainers.image.authors="Christian González Di Antonio <christiangda@gmail.com>" \
      org.opencontainers.image.authors="Elías Moreno <elias.moreno.tec@gmail.com>" \
      org.opencontainers.image.url="https://github.com/christiangda/docker-php" \
      org.opencontainers.image.documentation="https://github.com/christiangda/docker-php" \
      org.opencontainers.image.source="https://github.com/christiangda/docker-php" \
      org.opencontainers.image.version="${PHP_VERSION}" \
      org.opencontainers.image.vendor="Christian González Di Antonio <christiangda@gmail.com>, Elías Moreno <elias.moreno.tec@gmail.com>" \
      org.opencontainers.image.licenses="Apache License Version 2.0, The PHP License, version 3.01" \
      org.opencontainers.image.title="PHP version ${PHP_VERSION}" \
      org.opencontainers.image.description="PHP version ${PHP_VERSION} docker image"

RUN apk --no-cache --update add \
        bash \
        apache2=${APACHE_VERSION} \
        apache2-ctl=${APACHE_VERSION} \
        apache2-proxy=${APACHE_VERSION} \
        php7=${PHP_VERSION} \
        php7-bz2=${PHP_VERSION} \
        php7-ctype=${PHP_VERSION} \
        php7-curl=${PHP_VERSION} \
        php7-dom=${PHP_VERSION} \
        php7-fileinfo=${PHP_VERSION} \
        php7-fpm=${PHP_VERSION} \
        php7-ftp=${PHP_VERSION} \
        php7-gd=${PHP_VERSION} \
        php7-gettext=${PHP_VERSION} \
        php7-iconv=${PHP_VERSION} \
        php7-json=${PHP_VERSION} \
        php7-ldap=${PHP_VERSION} \
        php7-mbstring=${PHP_VERSION} \
        php7-mcrypt=${PHP_VERSION} \
        php7-memcached \
        php7-oauth \
        php7-openssl=${PHP_VERSION} \
        php7-pgsql=${PHP_VERSION} \
        php7-pdo=${PHP_VERSION} \
        php7-pdo_pgsql=${PHP_VERSION} \
        php7-pear=${PHP_VERSION} \
        php7-phar=${PHP_VERSION} \
        php7-posix=${PHP_VERSION} \
        php7-redis \
        php7-session=${PHP_VERSION} \
        php7-simplexml=${PHP_VERSION} \
        php7-soap=${PHP_VERSION} \
        php7-sqlite3=${PHP_VERSION} \
        php7-tokenizer=${PHP_VERSION} \
        php7-xml=${PHP_VERSION} \
        php7-xmlreader=${PHP_VERSION} \
        php7-xmlwriter=${PHP_VERSION} \
        php7-zip=${PHP_VERSION} \
        php7-zlib=${PHP_VERSION} \
      && rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

#
RUN set -ex \
    && rm -rf /etc/apache2/httpd.conf \
    && rm -rf /etc/apache2/conf.d/* \
    && mkdir -p ${APACHE_APP_ROOT} \
    && chown -R ${APACHE_USER}.${APACHE_GROUP} ${APACHE_HOME_ROOT}

# Copy provisioning files
COPY scripts/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Copy config files
COPY config/apache2/ /etc/apache2/
COPY config/fpm-pool-www.conf /etc/php7/php-fpm.d/www.conf
COPY config/php7/ /etc/php7/

COPY scripts/info.php ${APACHE_APP_ROOT}

# Ports
EXPOSE ${APACHE_PORT}

# Default command to run on boot Default command to run on boot
CMD ["/usr/local/bin/docker-entrypoint.sh"]
