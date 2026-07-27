# --- CONFIGURACION DE ENTORNO ---
$smtpServer = "smtp.gmail.com"
$smtpPort = 587
$usuarioEmail = "adahi55bady@gmail.com"
$passApp = "jbws aakw vvkk htvp"
$destinatario = "adahi55bady@gmail.com"

# --- RECOPILACION DE TELEMETRIA ---
$fecha = Get-Date -Format "dd/MM/yyyy HH:mm"
$urlPublica = "https://pionero-s01.tail47012e.ts.net/"
$cuerpoMsg = @"
Hola, Adahi.
El servidor PIONERO-S01 se ha reiniciado correctamente.
Estado de la infraestructura: ONLINE
Fecha y Hora del evento: $fecha
Acceso directo al Panel de Control: $urlPublica
"@

# --- PROCESO DE ENVIO SEGURO ---
try {
 $securePass = $passApp | ConvertTo-SecureString -AsPlainText -Force
 $credenciales = New-Object System.Management.Automation.PSCredential($usuarioEmail, $securePass)
 Send-MailMessage -SmtpServer $smtpServer `
 -Port $smtpPort `
 -UseSsl `
 -Credential $credenciales `
 -From $usuarioEmail `
 -To $destinatario `
 -Subject "⚠️ PIONERO-S01: Servidor Reiniciado Correctamente" `
 -Body $cuerpoMsg `
 -Encoding UTF8
 Write-Host "Notificacion por correo enviada con exito." -ForegroundColor Green
} catch {
 Write-Host "Error en la traza SMTP: $($_.Exception.Message)" -ForegroundColor Red
}
```[cite: 28]

---

### 2️⃣ Archivo: `iniciar_funnel.bat`[cite: 28]
*(Ruta/Nombre: `iniciar_funnel.bat`)*
```bat
@echo off
set TS="C:\Program Files\Tailscale\tailscale.exe"
set LOG="C:\Scripts\log_funnel.txt"
echo --- Inicio de log %date% %time% --- > %LOG%

:esperar_servicio
echo [%date% %time%] Esperando a que el servicio Tailscale este listo... >> %LOG%
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
echo [OK] Proceso automatizado completado con exito. >> %LOG%

:loop
timeout /t 3600 > nul
goto loop
```[cite: 28]

---

### 3️⃣ Archivo: `web.config`[cite: 28]
*(Ruta/Nombre: `web.config`)*
```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
 <system.web>
 <globalization fileEncoding="utf-8" requestEncoding="utf-8" responseEncoding="utf-8" culture="es-ES" uiCulture="es-ES" />
 </system.web>
 <system.webServer>
 <staticContent>
 <clientCache cacheControlMode="UseMaxAge" cacheControlMaxAge="00:00:01" />
 <remove fileExtension=".aspx" />
 <mimeMap fileExtension=".aspx" mimeType="text/html; charset=utf-8" />
 </staticContent>
 <security>
 <authentication>
 <anonymousAuthentication enabled="false" />
 <basicAuthentication enabled="true" />
 </authentication>
 </security>
 </system.webServer>
 <location path="index.aspx">
 <system.webServer>
 <security>
 <authentication>
 <anonymousAuthentication enabled="true" />
 </authentication>
 </security>
 </system.webServer>
 </location>
</configuration>
```[cite: 28]

---

## 📄 Paso 3: Solución para el PDF de la Memoria

Si GitHub no te deja subir el PDF desde la web, suele ser porque **supera los 25 MB** de límite para subida directa por el navegador.

Tienes **dos opciones muy sencillas**:

1. **Comprimir el PDF (Recomendado):**
   * Ve a una herramienta gratuita como [ILovePDF Compress](https://www.ilovepdf.com/es/comprimir_pdf) y comprime el archivo. Ocupará mucho menos de 25 MB y te dejará subirlo en GitHub sin problemas.
2. **Usar enlace a Google Drive / OneDrive en el `README.md`:**
   * Sube el PDF a Google Drive o OneDrive.
   * Obtén el enlace de compartir público.
   * En el archivo `README.md` de GitHub, en la sección de *Licencia y Documentación*, pones:  
     `📄 [Hacer clic aquí para ver/descargar la Memoria Técnica en PDF](TU_ENLACE_DE_DRIVE)`

---

¿Te parece bien crear primero estos archivos directamente en GitHub y comprimir el PDF para intentar subirlo de nuevo?
