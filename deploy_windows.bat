@echo off
:: Amrita Windows 快速部署脚本
:: 该脚本将在Windows环境下快速部署Amrita机器人

title Amrita 部署脚本

echo 🚀 开始部署 Amrita 机器人...
echo.

:: 检查Python版本
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未找到Python，请先安装Python 3.10或更高版本
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
for /f "delims=. tokens=1,2" %%a in ("%PYTHON_VERSION%") do (
    set PYTHON_MAJOR=%%a
    set PYTHON_MINOR=%%b
)

if %PYTHON_MAJOR% lss 3 (
    echo ❌ Python版本过低 (%PYTHON_VERSION%)，需要Python 3.10或更高版本
    pause
    exit /b 1
)

if %PYTHON_MAJOR% equ 3 if %PYTHON_MINOR% lss 10 (
    echo ❌ Python版本过低 (%PYTHON_VERSION%)，需要Python 3.10或更高版本
    pause
    exit /b 1
)

echo ✅ Python版本检查通过 (%PYTHON_VERSION%)

:: 检查uv是否已安装
uv --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️ 未找到uv，正在安装...
    pip install uv --break-system-packages
)

echo ✅ uv已安装

:: 安装Amrita及其完整依赖
echo 📥 正在安装Amrita及其依赖...
pip install amrita --break-system-packages

echo ✅ Amrita已安装
echo 🚀 正在初始化Amrita...

python -m amrita init

echo ✅ 部署完成！
echo.
echo 下一步操作：
echo 1. 编辑 .env 文件，设置 ADMIN_GROUP 为实际的管理员群组ID
echo 2. 运行 'amrita run' 启动机器人
echo.
echo 📝 注意事项：
echo - 确保防火墙允许端口11451的访问（如果需要外部访问）
echo - 数据库文件将存储在当前目录下的db.sqlite3
echo - 日志文件将存储在logs目录中
echo.
pause