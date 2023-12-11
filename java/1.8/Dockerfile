# 使用 alpine 作为基础镜像
FROM alpine:latest

# 设置中科大源
RUN echo "https://mirrors.ustc.edu.cn/alpine/latest-stable/main/" > /etc/apk/repositories \
    && echo "https://mirrors.ustc.edu.cn/alpine/latest-stable/community/" >> /etc/apk/repositories

# 安装 OpenJDK 8、curl、tar 和 bash
RUN apk --no-cache add openjdk8 curl tar bash


# 设置时区为上海
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

# 设置 Java 环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$PATH:$JAVA_HOME/bin"

# 检查 Java 版本
RUN java -version

# 设置工作目录
WORKDIR /app