# 使用官方 PHP 8.2.4 镜像作为基础镜像
FROM php:5.6-fpm-stretch

#Author
LABEL maintainer="Linfeiyang"
#Email
LABEL email="linfeiyang000@gmail.com"

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

RUN apt-get update
# 安装nginx
RUN apt-get install nginx -y

# 覆盖配置文件
COPY ./build/nginx.conf /etc/nginx/nginx.conf

# 添加php.ini到/usr/local/etc/php
#COPY ./php.ini /usr/local/etc/php/php.ini

# 安装一些必要的扩展
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://pecl.php.net/get/redis | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && docker-php-ext-install redis

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install bcmath
#RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype
#RUN docker-php-ext-install gd
RUN apt-get install libmagickwand-dev imagemagick -y
RUN pecl install imagick
RUN docker-php-ext-enable imagick 


# 添加ziparchive扩展
RUN docker-php-ext-configure zip && docker-php-ext-install zip

# 设置容器的默认工作目录为 /var/www/html
WORKDIR /var/www/html

#设置var目录权限
RUN chown -R www-data:www-data /var/lib/nginx

# 复制run.sh文件到容器中
COPY ./build/run.sh /run.sh

#清除apk cache

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 后台启动php-fpm 并前台运行nginx
CMD ["sh", "/run.sh"]