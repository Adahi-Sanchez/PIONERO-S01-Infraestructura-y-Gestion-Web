<%@ Page Language="C#" CodePage="65001" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>
<html lang="es">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>PIONERO-S01 | Centro de Soporte Tecnológico</title>
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
 :root { --p-blue: #2563eb; --p-dark: #0f172a; --p-accent: #fbbf24;
--p-bg: #f8fafc; }
body { font-family: 'Poppins', sans-serif; background-color:
var(--p-bg); color: var(--p-dark); }

 .navbar { background-color: var(--p-dark) !important; border-bottom:
3px solid var(--p-blue); padding: 15px 0; }
 .hero {
 background: linear-gradient(135deg, rgba(15, 23, 42, 0.95) 0%,
rgba(37, 99, 235, 0.8) 100%),

url('https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=2070&a
uto=format&fit=crop');
 min-height: 80vh; background-size: cover; background-position:
center; display: flex; align-items: center; color: white; padding: 60px 0;
 }
 .track-card { background: white; border-radius: 20px; color:
var(--p-dark); border: none; box-shadow: 0 20px 40px rgba(0,0,0,0.2); }
 .btn-accent { background-color: var(--p-accent); border: none;
font-weight: 700; color: var(--p-dark); }
 .status-box { border-radius: 12px; border-left: 5px solid
var(--p-blue); background: #f1f5f9; }

 .card-service { border: none; border-radius: 15px; transition: 0.3s;
background: white; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
 .card-service:hover { transform: translateY(-10px); }
 .icon-circle { width: 60px; height: 60px; background: rgba(37, 99, 235,
0.1); border-radius: 50%; display: flex; align-items: center; justify-content:
center; margin: 0 auto 15px; color: var(--p-blue); font-size: 1.5rem; }
 </style>
</head>
<body>
 <script runat="server">
 protected void btnConsultar_Click(object sender, EventArgs e)
 {
 string idTicket = txtTicketID.Value.Replace("#", "").Trim();
 string clNombre = txtNombreTrack.Value.Trim();
 string connStr = "Server=.;Database=ReparacionesDB;Integrated
Security=True;";
 try {
 using (SqlConnection conn = new SqlConnection(connStr)) {
 string sql = "SELECT Estado, Articulo FROM Solicitudes
WHERE ID = @id AND Cliente LIKE @nombre";
 SqlCommand cmd = new SqlCommand(sql, conn);
 cmd.Parameters.AddWithValue("@id", idTicket);
 cmd.Parameters.AddWithValue("@nombre", "%" + clNombre +
"%");
 conn.Open();
SqlDataReader r = cmd.ExecuteReader();
 pnlTrackResult.Visible = true;
 if (r.Read()) {
 string st = r["Estado"].ToString();
 lblStatusIcon.Text = (st == "Completado") ? "✅" :
"⏳";
 lblStatusText.Text = "ESTADO: " + st.ToUpper();
 lblStatusDesc.Text = "Tu " + r["Articulo"].ToString() +
" se encuentra " + st.ToLower() + ".";
 divStatusBox.Attributes["class"] = (st == "Completado")
? "status-box p-3 border-success" : "status-box p-3 border-warning";
 } else {
 lblStatusIcon.Text = "❌"; lblStatusText.Text = "NO
ENCONTRADO"; lblStatusDesc.Text = "Revisa los datos ingresados.";
 divStatusBox.Attributes["class"] = "status-box p-3
border-danger";
 }
 }
 } catch (Exception) { lblStatusText.Text = "ERROR DE CONEXIÓN"; }
 }
 </script>
 <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
 <div class="container">
 <a class="navbar-brand fw-bold" href="#"><i class="fas fa-microchip
me-2 text-primary"></i>PIONERO-S01</a>
 <div class="ms-auto d-flex align-items-center">
 <a class="nav-link text-white fw-bold me-3 d-none d-md-block"
href="calculadora.aspx"><i class="fas fa-calculator me-1 text-warning"></i>
CALCULADORA</a>
 <a href="solicitud.aspx" class="btn btn-primary fw-bold
shadow-sm">NUEVA SOLICITUD</a>
 </div>
 </div>
 </nav>
 <header class="hero">
 <div class="container">
 <div class="row align-items-center g-5">
 <div class="col-lg-6 text-center text-lg-start">
 <h1 class="display-4 fw-bold mb-4">Soporte Técnico <span
class="text-warning">Cáceres</span></h1>
 <p class="lead mb-4 opacity-90">Especialistas en hardware,
sistemas y mantenimiento industrial gestionados por Adahi.</p>
 <a href="#contacto" class="btn btn-outline-light btn-lg
px-4 fw-bold">CONTACTAR AHORA</a>
 </div>
 <div class="col-lg-5 offset-lg-1">
<div class="card track-card p-4 p-md-5">
 <h4 class="fw-bold mb-4"><i class="fas
fa-search-location me-2 text-primary"></i>Seguimiento</h4>
 <form id="formTrack" runat="server">
 <input type="text" id="txtTicketID" runat="server"
class="form-control mb-3" placeholder="ID Ticket (Ej: 15)" required>
 <input type="text" id="txtNombreTrack"
runat="server" class="form-control mb-3" placeholder="Nombre Cliente" required>
 <asp:Button ID="getTicket" ID="btnConsultar"
runat="server" OnClick="btnConsultar_Click" Text="BUSCAR TICKET" CssClass="btn
btn-accent w-100 py-2 shadow" />
 </form>
<asp:Panel ID="pnlTrackResult" runat="server"
Visible="false" class="mt-4">
 <div id="divStatusBox" runat="server"
class="status-box p-3">
 <div class="d-flex align-items-center">
 <span class="fs-2 me-3"><asp:Literal
ID="lblStatusIcon" runat="server"></asp:Literal></span>
 <div><h6 class="fw-bold m-0"><asp:Literal
ID="lblStatusText" runat="server"></asp:Literal></h6>
 <p class="small m-0 text-muted"><asp:Label
ID="lblStatusDesc" runat="server"></asp:Label></p></div>
 </div>
 </div>
 </asp:Panel>
 </div>
 </div>
 </div>
 </div>
 </header>
 <section class="container py-5">
 <div class="row g-4 text-center">
 <div class="col-md-4"><div class="card card-service p-4 h-100"><div
class="icon-circle"><i class="fas fa-laptop"></i></div><h6
class="fw-bold">Equipos Pro</h6></div></div>
 <div class="col-md-4"><div class="card card-service p-4 h-100"><div
class="icon-circle"><i class="fas fa-print"></i></div><h6
class="fw-bold">Impresoras 3D</h6></div></div>
 <div class="col-md-4"><div class="card card-service p-4 h-100"><div
class="icon-circle"><i class="fas fa-mobile-alt"></i></div><h6
class="fw-bold">Smartphones</h6></div></div>
 </div>
 </section>
 <section id="contacto" class="py-5 bg-white border-top">
 <div class="container">
 <div class="row g-5 align-items-center">
 <div class="col-lg-6">
 <h2 class="fw-bold mb-4">¿Hablamos? Soporte Directo</h2>
 <p class="text-muted mb-4">Estamos en Cáceres, listos para
atender cualquier fallo técnico en tus equipos. ¡Visítanos o llámanos!</p>
 <div class="d-flex align-items-center mb-3">
 <i class="fas fa-phone-alt text-primary fs-4 me-3"></i>
 <div><h6 class="mb-0 fw-bold">Llámanos</h6><p
class="mb-0 text-muted">653 51 42 65</p></div>
 </div>
 <div class="d-flex align-items-center mb-4">
 <i class="fas fa-envelope text-primary fs-4 me-3"></i>
 <div><h6 class="mb-0 fw-bold">Escríbenos</h6><p
class="mb-0 text-muted">adahi55bady@gmail.com</p></div>
 </div>
 <a href="https://www.google.com/maps/search/Caceres+España"
target="_blank" class="btn btn-dark btn-lg px-4 shadow-sm">
 <i class="fas fa-map-marked-alt me-2
text-warning"></i>CÓMO ENCONTRARNOS
 </a>
 </div>
 <div class="col-lg-6">
 <div class="p-4 bg-light rounded-4 border-start
border-primary border-5 shadow-sm">
 <h5 class="fw-bold mb-3 text-primary"><i class="fas
fa-server me-2"></i>Información del Nodo</h5>
 <table class="table table-sm table-borderless mb-0">
 <tr><th
class="ps-0">Servidor:</th><td>PIONERO-S01</td></tr>
 <tr><th class="ps-0">Admin:</th><td>Adahi</td></tr>
 <tr><th class="ps-0">Ubicación:</th><td>Cáceres,
Extremadura</td></tr>
 <tr><th class="ps-0">Estado:</th><td
class="text-success fw-bold">Online</td></tr>
 </table>
 </div>
 </div>
 </div>
 </div>
 </section>
 <footer class="py-5 bg-dark text-white-50 text-center">
 <div class="container small">
 <p class="mb-1 text-white fw-bold">PIONERO-S01 © 2026</p>
 <p>Infraestructura dedicada bajo SQL Server | Adahi</p>
 </div>
 </footer>
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.
js"></script>
</body>
</html>
