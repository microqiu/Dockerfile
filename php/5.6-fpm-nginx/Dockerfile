# 使用官方 PHP 8.2.4 镜像作为基础镜像
FROM php:7.0.4-fpm-alpine

#Author
LABEL maintainer="Linfeiyang"
#Email
LABEL email="linfeiyang000@gmail.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# 安装nginx
RUN apk add --no-cache nginx

# 覆盖配置文件
COPY ./build/nginx.conf /etc/nginx/nginx.conf

# 添加php.ini到/usr/local/etc/php
COPY ./php.ini /usr/local/etc/php/php.ini

# 安装一些必要的扩展

RUN apk add --no-cache $PHPIZE_DEPS
RUN pecl update-channels
RUN rm -rf /tmp/pear ~/.pearrc
RUN wget https://pecl.php.net/get/redis-5.3.7.tgz
RUN pecl install -o -f redis && rm -rf /tmp/pear && docker-php-ext-enable redis

RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-install bcmath

RUN apk add --no-cache \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        freetype-dev

RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype

RUN docker-php-ext-install gd

RUN apk add --update --no-cache autoconf g++ imagemagick imagemagick-dev libtool make pcre-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make pcre-dev

# 添加ziparchive扩展
RUN apk add --no-cache libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

# 设置容器的默认工作目录为 /var/www/html
WORKDIR /var/www/html

#设置var目录权限
RUN chown -R www-data:www-data /var/lib/nginx

# 复制run.sh文件到容器中
COPY ./build/run.sh /run.sh

#清除apk cache
RUN rm -rf /var/cache/apk/*

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 后台启动php-fpm 并前台运行nginx
CMD ["sh", "/run.sh"]