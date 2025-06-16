@echo off
echo Downloading ngrok...
curl -O https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-windows-amd64.zip
tar -xf ngrok-stable-windows-amd64.zip
ngrok authtoken %NGROK_AUTH_TOKEN%

echo Setting up RDP...
net user runneradmin YourPassword123 /add
net localgroup administrators runneradmin /add
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
powershell -Command "Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'"

echo Starting ngrok tunnel...
start ngrok tcp 3389

echo All done! Visit your ngrok dashboard to get the RDP address.
pause
