@echo off
echo 正在启动 ngrok Cloud Desktop...

REM 下载并解压 ngrok（Windows 64位版）
curl -Lo ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-windows-amd64.zip
powershell -Command "Expand-Archive ngrok.zip -DestinationPath ."
del ngrok.zip

REM 添加你的 NGROK_AUTH_TOKEN（已通过 GitHub Secrets 注入）
ngrok.exe config add-authtoken %NGROK_AUTH_TOKEN%

REM 启动远程桌面隧道（tcp 3389）
start ngrok.exe tcp 3389

REM 打印连接地址
echo 等待 ngrok 分配地址，请稍候...
timeout /t 10 >nul
curl http://127.0.0.1:4040/api/tunnels > tunnels.json
type tunnels.json

echo ==========
echo ✅ 请在日志中查找类似 "tcp://x.tcp.ngrok.io:xxxxx" 的地址
echo ✅ 用 Windows 远程桌面 (mstsc) 连接此地址登录云电脑！
echo ==========

pause
