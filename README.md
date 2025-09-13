# Amrita 部署指南

本文档介绍了在不同环境下部署 Amrita 机器人的方法。

## 目录

- [Docker 部署](#docker-部署)
- [Linux 直接部署](#linux-直接部署)
- [Windows 直接部署](#windows-直接部署)
- [配置说明](#配置说明)

## Docker 部署

### 使用 Dockerfile

```bash
# 构建镜像
docker build -t amrita-bot .

# 运行容器
docker run -d \
  --name amrita-bot \
  -p 11451:11451 \
  -v $(pwd)/data:/app/data \
  -v $(pwd)/logs:/app/logs \
  -v $(pwd)/config:/app/config \
  -v $(pwd)/db.sqlite3:/app/db.sqlite3 \
  -e ADMIN_GROUP=your_admin_group_id \ 
  -e WEBUI_USER=your_webui_username \
  -e WEBUI_PASSWORD=your_webui_password \
  amrita-bot
```

## Linux 直接部署

在 Linux 系统上，可以使用我们提供的部署脚本：

```bash
chmod +x deploy_linux.sh
./deploy_linux.sh
```

脚本将自动检查环境并安装依赖。

## Windows 直接部署

在 Windows 系统上，可以使用我们提供的部署脚本：

双击运行 `deploy_windows.bat` 文件，或者在命令行中执行：

```cmd
deploy_windows.bat
```

## 配置说明

部署前需要配置以下环境变量或在 `.env` 文件中设置，请参考[Amrita 配置说明](https://amrita.suggar.top/amrita/config.html)

注意：**ADMIN_GROUP 是必须配置的项**，请将其设置为你的管理员群组ID。

## 启动机器人

部署完成后，可以通过以下命令启动机器人：

```bash
python -m amrita run
```

或者在 Docker 环境中，容器会自动启动机器人。
