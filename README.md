# 🛡️ PIONERO-S01: Infraestructura de Red Corporativa, App Web y SOC/Ciberseguridad

> **Trabajo de Fin de Grado (TFG) - C.F.G.S. Administración de Sistemas Informáticos en Red (ASIR)**  
> **Autor:** Adahi Sánchez Gómez  
> **Centro:** IES Ágora (Cáceres)  

---

## 📋 Resumen Ejecutivo
**PIONERO-S01** es una infraestructura de red empresarial completa diseñada y desplegada bajo un modelo de arquitectura **Zero Trust** y alta resiliencia. El proyecto abarca desde la capa de hipervisor bare-metal hasta el desarrollo de una aplicación web Full-Stack para la gestión de incidencias, protegida mediante un stack de ciberseguridad proactivo (SIEM/NIDS/IPS) y monitorización en tiempo real.

---

## ⚙️ Stack Tecnológico & Arquitectura

* **Virtualización y Bare-Metal:** Proxmox VE 9.1 (KVM/LVM), Linux Bridge, NAT.
* **Servicios de Directorio & SO:** Windows Server 2022 (AD DS, DNS, DHCP, WSUS, IIS), Windows 11 Pro, Ubuntu Server.
* **Redes & VPN Mesh:** Tailscale (WireGuard SDN, Subnet Router, Tailscale Funnel), Nginx Reverse Proxy.
* **Desarrollo Web & Persistencia:** ASP.NET 4.8 (C#), HTML5, Bootstrap 5, Microsoft SQL Server 2022.
* **Security Stack & Defensa Activa:** Wazuh SIEM (HIDS/FIM), Suricata (NIDS), CrowdSec (IPS/CTI), Cisco Duo Security (MFA/2FA para RDP), Red Tor (Onion Service V3).
* **Automatización:** Scripts en PowerShell (`.ps1`) y Batch (`.bat`), Windows Task Scheduler, Relay SMTP Gmail.

---

## 🏛️ Componentes Principales del Sistema

### 1. Infraestructura Base & Servicios de Dominio
- **Controlador de Dominio (`reparaciones.local`):** Centralización de identidades, unidades organizativas (OUs), herencia de permisos NTFS y directivas de grupo corporativas (GPOs) para el mapeo automatizado de unidades de red.
- **Gestión Centralizada de Parches (WSUS):** Servidor local de actualización de software para despliegue auditado de parches críticos en clientes Windows 11.
- **Conectividad SDN:** Enrutamiento perimetral cifrado sin apertura de puertos físicos mediante Tailscale Subnet Router.

### 2. Aplicación Web & Motor Relacional
- **Portal de Clientes (`index.aspx` / `solicitud.aspx`):** Registro interactivo de averías y seguimiento en tiempo real de tickets de soporte mediante consultas SQL de coincidencia parcial (`LIKE`).
- **Dashboard Técnico (`gestion.aspx`):** Cuadro de mando administrativo protegido bajo **Autenticación de Windows (NTLM)** con indicadores KPI dinámicos (`SELECT COUNT(*)`) y filtrado en el cliente vía JavaScript.
- **Asesor de Salud Tecnológica (`calculadora.aspx`):** Algoritmo de diagnóstico de hardware en Backend para recomendación automatizada de upgrades.
- **Emisión de Tickets (`ticket.aspx`):** Generador de orden de trabajo física maquetado mediante reglas `@media print`.

### 3. Stack de Ciberseguridad & Hardening (Zero Trust)
- **SIEM & Monitorización de Integridad:** Agentes Wazuh desplegados para auditoría de eventos de seguridad (Event ID 4663) y supervisión FIM sobre directorios de producción.
- **Detección y Prevención de Intrusiones (NIDS/IPS):** Inspección profunda de paquetes con Suricata e inteligencia colectiva contra IPs maliciosas mediante CrowdSec Bouncer interconectado con el Firewall de Windows.
- **MFA en Accesos Administrativos:** Hardening del protocolo RDP integrando la API en la nube de **Cisco Duo Security** con desafío Push en dispositivos móviles.
- **Automatización de Servicios:** Scripts de persistencia para el restablecimiento automático de túneles de publicación y notificaciones SMTP inmediatas al correo del administrador ante reinicios del sistema.

---

## 📁 Estructura de Archivos del Repositorio

- `index.aspx`, `solicitud.aspx`, `gestion.aspx`: Código fuente del portal de gestión y seguimiento.
- `web.config`: Fichero de directivas perimetrales y excepciones de seguridad de IIS.
- `notificar_reinicio.ps1`: Script PowerShell de recopilación de telemetría y alerta SMTP.
- `iniciar_funnel.bat`: Script Batch de control de persistencia y reconexión de Tailscale Funnel.
