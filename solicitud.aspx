<%@ Page Language="C#" CodePage="65001" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>
<html lang="es">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>Nueva Solicitud | PIONERO-S01</title>
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
 :root { --pionero-blue: #2563eb; --pionero-dark: #0f172a;
--pionero-light: #f8fafc; }
 body { font-family: 'Poppins', sans-serif; background-color:
var(--pionero-light); color: var(--pionero-dark); }
 .navbar { background-color: var(--pionero-dark) !important;
border-bottom: 3px solid var(--pionero-blue); }

 .card { border: none; border-radius: 20px; overflow: hidden;
box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
 .card-header { background: linear-gradient(45deg, var(--pionero-dark),
var(--pionero-blue)); color: white; border: none; }

 .btn-primary { background-color: var(--pionero-blue); border: none;
font-weight: 600; padding: 12px; transition: 0.3s; }
 .btn-primary:hover { background-color: #1d4ed8; transform:
translateY(-2px); }

 .success-icon { font-size: 4rem; color: #10b981; }
 .id-badge { background: #f1f5f9; border: 2px dashed
var(--pionero-blue); border-radius: 15px; padding: 20px; }

 .input-group-text { background-color: white; color:
var(--pionero-blue); border-right: none; }
 .form-control { border-left: none; }
 .form-control:focus { border-color: #dee2e6; box-shadow: none; }
 </style>
</head>
<body>
 <script runat="server">
 protected void btnEnviar_Click(object sender, EventArgs e)
 {
 string connectionString =
"Server=.;Database=ReparacionesDB;Integrated Security=True;";
 try {
 using (SqlConnection conn = new
SqlConnection(connectionString))
 {
 string query = "INSERT INTO Solicitudes (Cliente, Articulo,
Descripcion, Estado) VALUES (@cliente, @articulo, @desc, 'Pendiente'); SELECT
SCOPE_IDENTITY();";
 SqlCommand cmd = new SqlCommand(query, conn);
 cmd.Parameters.AddWithValue("@cliente", txtCliente.Value);
 cmd.Parameters.AddWithValue("@articulo", txtEquipo.Value);
 cmd.Parameters.AddWithValue("@desc", txtAveria.Value);

 conn.Open();
 object newId = cmd.ExecuteScalar();

 pnlFormulario.Visible = false;
 pnlExito.Visible = true;

 lblIDFinal.Text = "#" + newId.ToString();
lblNombreFinal.Text = txtCliente.Value;
 }
 }
 catch (Exception ex) {
 lblError.Text = "❌ Error en el servidor: " + ex.Message;
 lblError.Visible = true;
 }
 }
 </script>
 <nav class="navbar navbar-dark mb-5 shadow">
 <div class="container">
 <a class="navbar-brand fw-bold" href="index.aspx"><i class="fas
fa-arrow-left me-2 text-primary"></i> VOLVER AL INICIO</a>
 </div>
 </nav>
 <div class="container">
 <div class="row justify-content-center">
 <div class="col-md-7 col-lg-6">

 <asp:Panel ID="pnlFormulario" runat="server">
 <div class="card">
 <div class="card-header py-4 text-center">
 <i class="fas fa-file-invoice fa-3x mb-3"></i>
 <h2 class="fw-bold m-0">Orden de Servicio</h2>
 <p class="small opacity-75 mt-2">Introduce los
datos para el nodo PIONERO-S01</p>
 </div>
<div class="card-body p-4 p-md-5">
 <form id="form1" runat="server">
 <asp:Label ID="lblError" runat="server"
CssClass="alert alert-danger d-block" Visible="false"></asp:Label>

<div class="mb-4">
 <label class="form-label fw-bold small
text-uppercase">Nombre del Cliente</label>
 <div class="input-group shadow-sm">
 <span class="input-group-text"><i
class="fas fa-user"></i></span>
 <input type="text" id="txtCliente"
runat="server" class="form-control" placeholder="Ej: Juan Pérez" required>
 </div>
 </div>
 <div class="mb-4">
 <label class="form-label fw-bold small
text-uppercase">Equipo / Dispositivo</label>
 <div class="input-group shadow-sm">
 <span class="input-group-text"><i
class="fas fa-laptop"></i></span>
 <input type="text" id="txtEquipo"
runat="server" class="form-control" placeholder="Ej: Portátil MSI / Impresora
HP" required>
 </div>
 </div>
 <div class="mb-4">
 <label class="form-label fw-bold small
text-uppercase">Descripción del Problema</label>
 <div class="input-group shadow-sm">
 <span class="input-group-text"><i
class="fas fa-comment-alt"></i></span>
 <textarea id="txtAveria" runat="server"
class="form-control" rows="4" placeholder="¿Qué le ocurre al equipo?"
required></textarea>
 </div>
 </div>
 <asp:LinkButton ID="btnEnviar" runat="server"
OnClick="btnEnviar_Click" CssClass="btn btn-primary w-100 shadow mt-2">
 <i class="fas fa-paper-plane me-2"></i>
REGISTRAR EN SQL SERVER
 </asp:LinkButton>
 </form>
 </div>
 </div>
 </asp:Panel>
 <asp:Panel ID="pnlExito" runat="server" Visible="false">
 <div class="card text-center p-5">
 <div class="mb-4">
 <i class="fas fa-check-circle success-icon"></i>
 </div>
<h2 class="fw-bold">¡Solicitud Registrada!</h2>
 <p class="text-muted mb-4">Tu ticket ha sido guardado
correctamente en nuestra base de datos.</p>

<div class="id-badge mb-4">
 <div class="mb-2">
 <small class="text-uppercase fw-bold
text-muted">ID de Seguimiento</small>
 <h1 class="display-4 fw-bold text-primary
m-0"><asp:Literal ID="lblIDFinal" runat="server"></asp:Literal></h1>
 </div>
<div class="mt-3 pt-3 border-top">
 <small class="text-uppercase fw-bold
text-muted">Nombre Registrado</small>
 <h5 class="fw-bold text-dark m-0"><asp:Literal
ID="lblNombreFinal" runat="server"></asp:Literal></h5>
 </div>
 </div>
 <div class="alert alert-info border-0 shadow-sm mb-4">
 <i class="fas fa-info-circle me-2"></i>
<strong>Importante:</strong> Usa estos dos datos en la página de inicio para
consultar el estado de tu reparación.
 </div>
 <a href="index.aspx" class="btn btn-dark w-100 py-3
fw-bold rounded-pill">
 <i class="fas fa-home me-2"></i> VOLVER A LA
PORTADA
 </a>
 </div>
 </asp:Panel>
 </div>
 </div>
 </div>
 <script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.
js"></script>
</body>
</html>
