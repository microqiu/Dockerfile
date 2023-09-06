# 使用官方 PHP 8.2.4 镜像作为基础镜像
FROM php:5.6-fpm-stretch

#Author
LABEL maintainer="Linfeiyang"
#Email
LABEL email="linfeiyang000@gmail.com"


RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

RUN apt-get update

# 安装nginx
RUN apt-get install nginx -y

# 覆盖配置文件
COPY ./build/nginx.conf /etc/nginx/nginx.conf

# 添加php.ini到/usr/local/etc/php
#COPY ./php.ini /usr/local/etc/php/php.ini
RUN apt-get install wget -y

# 安装一些必要的扩展
RUN wget http://pecl.php.net/get/redis-4.2.0.tgz
RUN tar -zxvf redis-4.2.0.tgz && cd redis-4.2.0 && phpize && ./configure && make && make install
RUN docker-php-ext-enable redis

# imagick
RUN apt-get install -y libmagickwand-dev libmagickcore-dev
RUN wget http://pecl.php.net/get/imagick-3.4.4.tgz
RUN tar -zxvf imagick-3.4.4.tgz && cd imagick-3.4.4 && phpize && ./configure --prefix=/usr/local/imagemagick && make && make install
RUN docker-php-ext-enable redis


RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install bcmath
#RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype
#RUN docker-php-ext-install gd


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