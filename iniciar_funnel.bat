@echo off
set TS="C:\Program Files\Tailscale\tailscale.exe"
set LOG="C:\Scripts\log_funnel.txt"
echo --- Inicio de log %date% %time% --- > %LOG%
:esperar_servicio
echo [%date% %time%] Esperando a que el servicio Tailscale este listo... >>
%LOG%
%TS% status >nul 2>&1
if %errorlevel% neq 0 (
 echo [!] Servicio no responde todavia. Esperando 5 segundos... >> %LOG%
 timeout /t 5 /nobreak >nul
 goto esperar_servicio
)
echo [+] Servicio de red detectado. Procediendo... >> %LOG%
echo Limpiando sockets previos de servicios... >> %LOG%
%TS% serve reset >> %LOG% 2>&1
echo Iniciando exposicion de puerto de aplicacion web 8080... >> %LOG%
%TS% funnel 8080 >> %LOG% 2>&1
148
Adahi Sánchez Gómez - Proyecto Final ASIR.
echo [OK] Proceso automatizado completado con exito. >> %LOG%
:loop
timeout /t 3600 > nul
goto loop
