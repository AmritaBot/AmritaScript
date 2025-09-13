FROM python:3.10-slim

WORKDIR /app

# 设置环境变量
ENV ENVIRONMENT=prod
ENV DRIVER=~fastapi
ENV LOCALSTORE_USE_CWD=true
ENV LOG_DIR=logs

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 复制项目文件
COPY . .

# 安装项目依赖
RUN pip install uv \
    && pip install amrita --break-system-packages

RUN amrita init

# 暴露端口
EXPOSE 11451

# 创建卷以持久化数据
VOLUME ["/app/data", "/app/logs", "/app/config"]

# 启动命令
CMD ["python", "-m", "amrita", "run"]