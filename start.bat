@echo off
title ☁️ GitHub Cloud Desktop for Xbox Cloud Gaming
echo 正在准备 Windows 云桌面环境...

:: 安装 Microsoft Edge
echo 正在安装 Microsoft Edge...
powershell -command "Invoke-WebRequest 'https://go.microsoft.com/fwlink/?LinkId=2109044' -OutFile 'edge_installer.exe'"
start /wait edge_installer.exe

:: 开启远程桌面服务
echo 启用远程桌面...
net localgroup administrators runneradmin /add
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
powershell -command "Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'"

:: 设置登录密码
net user runneradmin YourPassword123

:: 下载并配置 ngrok
echo 下载 ngrok...
curl -o ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip
powershell -command "Expand-Archive ngrok.zip -DestinationPath ."
echo 启动 ngrok 隧道...
ngrok.exe authtoken %NGROK_AUTH_TOKEN%
start /b ngrok.exe tcp 3389 > ngrok.log

:: 等待 ngrok 初始化
timeout /t 10 > nul

:: 显示连接信息
echo ====== ✅ 远程桌面连接地址如下：======
type ngrok.log
echo 用户名: runneradmin
echo 密码: YourPassword123
echo ============================================
echo.

:: 启动 Xbox Cloud Gaming 页面
echo 打开 Xbox Cloud Gaming...
start msedge https://xbox.com/play

pause
