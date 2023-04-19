#!/bin/sh
php-fpm -D
nginx
tail -f /dev/stdout