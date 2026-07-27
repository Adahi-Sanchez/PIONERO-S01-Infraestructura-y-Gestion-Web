<%@ Page Language="C#" CodePage="65001" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>
<html lang="es">
<head>
 <meta charset="UTF-8">
 <title>Ticket_Reparacion_PIONERO</title>
 <link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
rel="stylesheet">
 <style>
 body { background: #fff; font-family: 'Segoe UI', sans-serif; padding:
40px; }
 .ticket-box { border: 2px solid #000; padding: 30px; max-width: 800px;
margin: 0 auto; position: relative; }
 .stamp { position: absolute; top: 30px; right: 30px; border: 4px solid
#10b981; color: #10b981; padding: 10px; font-weight: bold; transform:
rotate(15deg); text-transform: uppercase; border-radius: 10px; }
 @media print {
 .no-print { display: none; }
 body { padding: 0; }
 .ticket-box { border: none; }
 }
 </style>
</head>
<body>
 <script runat="server">
 protected void Page_Load(object sender, EventArgs e)
 {
 string id = Request.QueryString["id"];
 if (string.IsNullOrEmpty(id)) Response.Redirect("gestion.aspx");
 string connStr = "Server=.;Database=ReparacionesDB;Integrated
Security=True;";
 using (SqlConnection conn = new SqlConnection(connStr))
 {
 SqlCommand cmd = new SqlCommand("SELECT * FROM Solicitudes
WHERE ID = @id", conn);
 cmd.Parameters.AddWithValue("@id", id);
 conn.Open();
 SqlDataReader r = cmd.ExecuteReader();
 if (r.Read()) {
 lblID.Text = r["ID"].ToString();
 lblCliente.Text = r["Cliente"].ToString();
 lblArticulo.Text = r["Articulo"].ToString();
 lblDesc.Text = r["Descripcion"].ToString();
 lblEstado.Text = r["Estado"].ToString();
 lblFecha.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
 }
 }
 }
 </script>
 <div class="no-print text-center mb-4">
 <button onclick="window.print()" class="btn btn-primary btn-lg"><i
class="fas fa-print"></i> IMPRIMIR / GUARDAR PDF</button>
 <a href="gestion.aspx" class="btn btn-outline-secondary btn-lg">VOLVER
A GESTIÓN</a>
 </div>
 <div class="ticket-box">
 <div class="row mb-5">
 <div class="col-6">
 <h1 class="fw-bold text-primary">PIONERO-S01</h1>
 <p class="mb-0">Servicio Técnico Especializado</p>
 <p class="mb-0">Cáceres, Extremadura</p>
 <p>Tel: 653 51 42 65</p>
 </div>
 <div class="col-6 text-end">
 <h4 class="fw-bold">ORDEN DE SERVICIO</h4>
 <h2 class="text-danger fw-bold">#<asp:Literal ID="lblID"
runat="server"></asp:Literal></h2>
<p class="text-muted">Emitido el: <asp:Literal ID="lblFecha"
runat="server"></asp:Literal></p>
 </div>
 </div>
 <div class="stamp"><asp:Literal ID="lblEstado"
runat="server"></asp:Literal></div>
 <table class="table table-bordered border-dark mt-4">
 <tr class="table-light"><th
width="30%">CLIENTE</th><td><asp:Literal ID="lblCliente"
runat="server"></asp:Literal></td></tr>
 <tr><th>EQUIPO / DISPOSITIVO</th><td><asp:Literal ID="lblArticulo"
runat="server"></asp:Literal></td></tr>
 <tr><th height="100">TRABAJO REALIZADO /
DESCRIPCIÓN</th><td><asp:Literal ID="lblDesc"
runat="server"></asp:Literal></td></tr>
 </table>
 <div class="row mt-5">
 <div class="col-6 text-center">
 <div style="border-top: 1px solid #000; width: 80%; margin:
40px auto 0;">Firma Técnico (Adahi)</div>
 </div>
 <div class="col-6 text-center">
 <div style="border-top: 1px solid #000; width: 80%; margin:
40px auto 0;">Firma Cliente</div>
 </div>
 </div>
 <div class="mt-5 pt-5 text-center text-muted small">
 Este documento es un comprobante de servicio generado por el
sistema PIONERO-S01.
 </div>
 </div>
 <script src="https://kit.fontawesome.com/a076d05399.js"
crossorigin="anonymous"></script>
</body>
</html>
