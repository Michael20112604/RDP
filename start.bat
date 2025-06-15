@echo off
echo 正在启动 Windows Cloud Desktop...

:: 设置远程桌面密码（你可以改成你想要的密码）
net user runneradmin YourPassword123

:: 下载并解压 ngrok
curl -Lo ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-windows-amd64.zip
powershell -Command "Expand-Archive ngrok.zip -DestinationPath ."
del ngrok.zip

:: 配置 ngrok token（需要你在 GitHub Secrets 中添加 NGROK_AUTH_TOKEN）
ngrok.exe config add-authtoken %NGROK_AUTH_TOKEN%

:: 启动 ngrok 隧道
start /b ngrok.exe tcp 3389

echo 等待 ngrok 启动...
timeout /t 15 >nul

:: 获取 ngrok 地址并输出
powershell -Command "$t=(Invoke-RestMethod http://127.0.0.1:4040/api/tunnels).tunnels[0].public_url; echo 连接此地址登录云电脑！; echo %USERNAME%@%COMPUTERNAME%; echo 地址：$t"

pause
