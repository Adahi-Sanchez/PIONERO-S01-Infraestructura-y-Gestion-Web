<%@ Page Language="C#" CodePage="65001" %>
<!DOCTYPE html>
<html lang="es">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>Asesor Tech Dinámico | PIONERO-S01</title>
 <link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">
 <link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css
">
 <link
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&dis
play=swap" rel="stylesheet">
 <style>
 :root { --pionero-blue: #2563eb; --pionero-dark: #0f172a; }
 body { font-family: 'Poppins', sans-serif; background-color: #f1f5f9; }
 .card-calc { border: none; border-radius: 20px; box-shadow: 0 15px 35px
rgba(0,0,0,0.1); overflow: hidden; }
 .bg-header { background: linear-gradient(135deg, var(--pionero-dark)
0%, var(--pionero-blue) 100%); color: white; }
 .form-label { font-weight: 600; font-size: 0.9rem; color:
var(--pionero-dark); }
 .section-extra { display: none; padding: 20px; background: #f8fafc;
border-radius: 12px; border-left: 5px solid var(--pionero-blue); }
result-box { border-radius: 15px; padding: 25px; border: none; }
 </style>
</head>
<body>
 <script runat="server">
 protected void btnAnalizar_Click(object sender, EventArgs e)
 {
 string tipo = selTipo.Value;
 string marca = txtMarca.Value;
 pnlResultado.Visible = true;
 lblEquipo.Text = string.Format("{0} {1}", marca, tipo);
 if (tipo == "Ordenador" || tipo == "Portátil") {
 if (selRam.Value == "4" || selDisco.Value == "HDD") {
 lblScore.Text = "🔴 ESTADO CRÍTICO (NECESITA UPGRADE)";
 lblRec.Text = "Tu equipo tiene un cuello de botella en la
RAM o el Disco. Te recomendamos instalar un SSD y subir a 16GB para
PIONERO-S01.";
 divResult.Attributes["class"] = "result-box bg-danger
text-white shadow";
 } else {
 lblScore.Text = "🟢 RENDIMIENTO EXCELENTE";
 lblRec.Text = "Tu configuración es sólida. Un mantenimiento
preventivo anual será suficiente.";
 divResult.Attributes["class"] = "result-box bg-success
text-white shadow";
 }
 } else if (tipo.Contains("Impresora")) {
 if (selUso.Value == "Alto") {
 lblScore.Text = "🟡 MANTENIMIENTO REQUERIDO";
 lblRec.Text = "Por el alto volumen de impresiones, es
necesario revisar rodillos y cabezales para evitar atascos.";
 divResult.Attributes["class"] = "result-box bg-warning
text-dark shadow";
 } else {
 lblScore.Text = "🟢 ESTADO ÓPTIMO";
 lblRec.Text = "Impresora lista para trabajar. Recuerda usar
consumibles de calidad.";
 divResult.Attributes["class"] = "result-box bg-success
text-white shadow";
 }
 } else {
 lblScore.Text = "🔵 ANÁLISIS COMPLETADO";
 lblRec.Text = "Hemos registrado las especificaciones de tu
dispositivo móvil. Te contactaremos con una valoración personalizada.";
 divResult.Attributes["class"] = "result-box bg-primary
text-white shadow";
 }
}
 </script>
 <nav class="navbar navbar-dark bg-dark mb-4">
 <div class="container"><a class="navbar-brand fw-bold"
href="index.aspx">PIONERO-S01</a></div>
 </nav>
 <div class="container pb-5">
 <div class="row justify-content-center">
 <div class="col-lg-10 col-xl-8">
 <div class="card card-calc bg-white">
 <div class="bg-header p-4 text-center">
 <i class="fas fa-microchip fa-3x mb-3
text-warning"></i>
 <h2 class="fw-bold m-0">Asesor de Salud
Tecnológica</h2>
 <p class="opacity-75">Configuración avanzada por
Adahi</p>
 </div>
 <div class="card-body p-4 p-md-5">
 <form id="form1" runat="server">
 <div class="row g-4">
 <div class="col-md-6">
 <label class="form-label">Tipo de
Dispositivo</label>
 <select id="selTipo" runat="server"
class="form-select form-select-lg" onchange="mostrarCampos()">
 <option value="Ordenador">Ordenador de
Sobremesa</option>
 <option value="Portátil">Ordenador
Portátil</option>
 <option value="Teléfono">Teléfono Móvil
/ Tablet</option>
 <option value="Impresora">Impresora
Normal</option>
 <option value="Impresora 3D">Impresora
3D</option>
 </select>
 </div>
<div class="col-md-6">
 <label class="form-label">Marca del
Fabricante</label>
 <input type="text" id="txtMarca"
runat="server" class="form-control form-control-lg" placeholder="Ej: MSI, HP,
Apple..." required>
 </div>
 <div id="secPC" class="col-12 section-extra"
style="display:block;">
 <div class="row g-3">
 <div class="col-md-4">
 <label class="form-label">Memoria
RAM</label>
 <select id="selRam" runat="server"
class="form-select">
 <option value="4">4GB o
menos</option>
 <option value="8">8GB
(Estándar)</option>
 <option value="16">16GB o más
(Pro)</option>
 </select>
 </div>
<div class="col-md-4">
 <label class="form-label">Tipo de
Disco</label>
 <select id="selDisco"
runat="server" class="form-select">
 <option value="SSD">SSD
(Rápido)</option>
 <option value="HDD">HDD
(Lento)</option>
 <option value="NVMe">M.2 NVMe
(Ultra)</option>
 </select>
 </div>
<div class="col-md-4">
 <label
class="form-label">Procesador</label>
 <select id="selCpu" runat="server"
class="form-select">
 <option value="I3">Gama Básica
(i3/Ryzen 3)</option>
 <option value="I5">Gama Media
(i5/Ryzen 5)</option>
 <option value="I7">Gama Alta
(i7/Ryzen 7)</option>
 </select>
 </div>
 </div>
 </div>
 <div id="secPrinter" class="col-12
section-extra">
 <div class="row g-3">
 <div class="col-md-6">
 <label class="form-label">Volumen
de Impresión</label>
 <select id="selUso" runat="server"
class="form-select">
 <option value="Bajo">Poco
(Doméstico)</option>
 <option value="Medio">Medio
(Oficina)</option>
 <option value="Alto">Alto
(Industrial)</option>
 </select>
 </div>
<div class="col-md-6">
 <label
class="form-label">Conectividad</label>
 <select id="selConn" runat="server"
class="form-select">
 <option value="USB">Cable
USB</option>
 <option value="Wifi">WiFi /
Red</option>
 </select>
 </div>
 </div>
 </div>
 <div id="secMobile" class="col-12
section-extra">
 <div class="row g-3">
 <div class="col-md-6">
 <label class="form-label">Estado de
Pantalla</label>
 <select id="selScreen"
runat="server" class="form-select">
 <option
value="OK">Perfecta</option>
 <option value="Rota">Rota /
Rajada</option>
 <option value="Manchas">Manchas
/ Pixeles</option>
 </select>
 </div>
<div class="col-md-6">
 <label class="form-label">Salud de
Batería</label>
 <select id="selBat" runat="server"
class="form-select">
 <option value="Buena">Dura todo
el día</option>
 <option value="Media">Se agota
rápido</option>
 <option value="Mala">Solo
funciona enchufado</option>
 </select>
 </div>
 </div>
 </div>
 <div class="col-12 text-center pt-3">
 <asp:Button ID="btnAnalizar" runat="server"
OnClick="btnAnalizar_Click" Text="OBTENER DIAGNÓSTICO" CssClass="btn
btn-primary btn-lg px-5 fw-bold shadow" />
 </div>
 </div>
 </form>
 <asp:Panel ID="pnlResultado" runat="server"
Visible="false" class="mt-5">
 <div id="divResult" runat="server">
 <h4 class="fw-bold mb-1"><asp:Literal
ID="lblScore" runat="server"></asp:Literal></h4>
 <p class="small opacity-75">Equipo: <asp:Label
ID="lblEquipo" runat="server"></asp:Label></p>
 <hr style="border-color:
rgba(255,255,255,0.2)">
 <p class="mb-0 fw-bold"><asp:Label ID="lblRec"
runat="server"></asp:Label></p>
 </div>
<div class="text-center mt-4">
 <a href="solicitud.aspx" class="btn
btn-outline-dark btn-sm fw-bold">SOLICITAR PRESUPUESTO BASADO EN ESTE
ANÁLISIS</a>
 </div>
 </asp:Panel>
 </div>
 </div>
 </div>
 </div>
 </div>
 <script>
 function mostrarCampos() {
 var tipo = document.getElementById('<%= selTipo.ClientID
%>').value;
 document.getElementById('secPC').style.display = 'none';
 document.getElementById('secPrinter').style.display = 'none';
 document.getElementById('secMobile').style.display = 'none';
 if (tipo === "Ordenador" || tipo === "Portátil") {
 document.getElementById('secPC').style.display = 'block';
 } else if (tipo === "Impresora" || tipo === "Impresora 3D") {
 document.getElementById('secPrinter').style.display = 'block';
 } else if (tipo === "Teléfono" || tipo === "Tablet") {
 document.getElementById('secMobile').style.display = 'block';
 }
 }
 </script>
</body>
</html>
