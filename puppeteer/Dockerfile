# 使用 Node.js 20.6 的官方镜像作为基础镜像
FROM node:21

# 设置工作目录为 /app
WORKDIR /app

# 复制当前目录下的所有文件到工作目录
COPY . .

# 安装 Puppeteer 依赖
RUN npm install puppeteer

# 设置启动命令
CMD ["node", "your-app-file.js"]