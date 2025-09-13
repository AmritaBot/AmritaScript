#!/bin/bash

set -e  # 遇到错误时终止脚本

echo "🚀 开始部署 Amrita ..."


# 检查Python版本
if ! command -v python3 &> /dev/null; then
    echo "❌ 未找到Python3，请先安装Python3.10或更高版本"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
PYTHON_MAJOR=$(echo "$PYTHON_VERSION" | cut -d'.' -f1)
PYTHON_MINOR=$(echo "$PYTHON_VERSION" | cut -d'.' -f2)

if [ "$PYTHON_MAJOR" -lt 3 ] || { [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 10 ]; }; then
    echo "❌ Python版本过低 ($PYTHON_VERSION)，需要Python 3.10或更高版本"
    exit 1
fi

echo "✅ Python版本检查通过 ($PYTHON_VERSION)"

# 检查uv是否已安装
if ! command -v uv &> /dev/null; then
    echo "⚠️ 未找到uv，正在安装..."
    pip install uv
fi

echo "✅ uv已安装"

# 安装Amrita及其完整依赖
echo "📥 正在安装Amrita CLI..."
pip install amrita --break-system-packages

echo "✅ Amrita已安装"
echo "🚀 正在初始化Amrita..."

python -m amrita init

echo " 🚀 Amrita完成初始化！"

echo "⚠️  请编辑.env文件，设置ADMIN_GROUP为实际的管理员群组ID"

echo "✅ 部署完成！"
echo ""
echo "下一步操作："
echo "1. 编辑 .env 文件，设置 ADMIN_GROUP 为实际的管理员群组ID"
echo "2. 运行 'python -m amrita run' 启动机器人"
echo "3. 或者使用 'nohup python bot.py > amrita.log 2>&1 &' 在后台运行"
echo ""
echo "📝 注意事项："
echo "- 确保防火墙允许端口11451的访问（如果需要外部访问）"
echo "- 数据库文件将存储在当前目录下的data.db，如果需要使用外部数据库请配置环境变量！"
echo "- 日志文件将存储在logs目录中"