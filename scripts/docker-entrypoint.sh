#!/usr/bin/env bash
set -e

/usr/sbin/php-fpm7 -c /etc/php7/php-fpm.conf -D && /usr/sbin/apachectl -D FOREGROUND
