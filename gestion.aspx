<%@ Page Language="C#" CodePage="65001" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html>
<html lang="es">
<head>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>Panel de Control | PIONERO-S01</title>
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
 :root { --p-blue: #2563eb; --p-dark: #0f172a; --p-light: #f1f5f9;
--p-red: #ef4444; }
body { font-family: 'Poppins', sans-serif; background-color:
var(--p-light); }
 .navbar { background-color: var(--p-dark) !important; border-bottom:
3px solid var(--p-blue); }

 /* KPIs */
 .stat-card { border: none; border-radius: 15px; position: relative;
overflow: hidden; transition: 0.3s; }
 .stat-icon { font-size: 2.5rem; opacity: 0.2; position: absolute;
right: 15px; bottom: 10px; }

 .nav-pills .nav-link { color: var(--p-dark); font-weight: 600;
border-radius: 50px; padding: 8px 20px; }
 .nav-pills .nav-link.active { background-color: var(--p-blue); }

 .card-table { border: none; border-radius: 15px; overflow: hidden;
box-shadow: 0 10px 25px rgba(0,0,0,0.05); background: white; }
 .table thead { background-color: var(--p-dark); color: white; }

 .btn-action { transition: 0.2s; }
 .btn-action:hover { transform: scale(1.1); }

 .row-completed { opacity: 0.6; background-color: #f8fafc; }
 .row-completed td:not(:last-child) { text-decoration: line-through; }
 </style>
</head>
<body>
 <script runat="server">
 string connStr = "Server=.;Database=ReparacionesDB;Integrated
Security=True;";
 string currentFilter = "all";
 int contPendientes = 0;
 int contCompletados = 0;
 protected void Page_Load(object sender, EventArgs e)
 {
 currentFilter = Request.QueryString["f"] ?? "all";
 using (SqlConnection conn = new SqlConnection(connStr))
 {
 conn.Open();

 // 1. PROCESAR ACCIONES
 if (!string.IsNullOrEmpty(Request.QueryString["done"]))
 {
 SqlCommand cmd = new SqlCommand("UPDATE Solicitudes SET
Estado = 'Completado' WHERE ID = @id", conn);
cmd.Parameters.AddWithValue("@id",
Request.QueryString["done"]);
 cmd.ExecuteNonQuery();
 Response.Redirect("gestion.aspx?f=" + currentFilter);
 }
 if (!string.IsNullOrEmpty(Request.QueryString["del"]))
 {
 SqlCommand cmd = new SqlCommand("DELETE FROM Solicitudes
WHERE ID = @id", conn);
 cmd.Parameters.AddWithValue("@id",
Request.QueryString["del"]);
 cmd.ExecuteNonQuery();
 Response.Redirect("gestion.aspx?f=" + currentFilter);
 }
 // 2. ACTUALIZAR CONTADORES
 SqlCommand cmdP = new SqlCommand("SELECT COUNT(*) FROM
Solicitudes WHERE Estado = 'Pendiente'", conn);
 contPendientes = (int)cmdP.ExecuteScalar();
 SqlCommand cmdC = new SqlCommand("SELECT COUNT(*) FROM
Solicitudes WHERE Estado = 'Completado'", conn);
 contCompletados = (int)cmdC.ExecuteScalar();
 }
 }
 </script>
 <nav class="navbar navbar-dark shadow sticky-top">
 <div class="container">
 <span class="navbar-brand fw-bold"><i class="fas fa-terminal me-2
text-primary"></i>SISTEMA DE GESTIÓN PIONERO-S01</span>
 <a href="index.aspx" class="btn btn-outline-light btn-sm
rounded-pill px-3">SALIR</a>
 </div>
 </nav>
 <div class="container py-4">

 <div class="row g-3 mb-4 text-white">
 <div class="col-md-4">
 <div class="card stat-card bg-primary p-3 shadow-sm h-100">
 <small class="text-uppercase fw-bold opacity-75">En
Espera</small>
 <h2 class="display-5 fw-bold m-0 text-white"><%=
contPendientes %></h2>
 <i class="fas fa-clock stat-icon"></i>
 </div>
 </div>
<div class="col-md-4">
 <div class="card stat-card bg-success p-3 shadow-sm h-100">
 <small class="text-uppercase fw-bold
opacity-75">Finalizados</small>
 <h2 class="display-5 fw-bold m-0 text-white"><%=
contCompletados %></h2>
 <i class="fas fa-check-circle stat-icon"></i>
 </div>
 </div>
 <div class="col-md-4">
 <div class="card stat-card bg-dark p-3 shadow-sm h-100
border-start border-primary border-5">
 <small class="text-uppercase fw-bold opacity-75
text-primary">Total SQL</small>
 <h2 class="display-5 fw-bold m-0 text-white"><%=
contPendientes + contCompletados %></h2>
 <i class="fas fa-database stat-icon"></i>
 </div>
 </div>
 </div>
 <div class="row g-3 mb-4 align-items-center">
 <div class="col-md-6 text-center text-md-start">
 <ul class="nav nav-pills shadow-sm p-1 bg-white rounded-pill
d-inline-flex border">
 <li class="nav-item"><a class="nav-link <%= currentFilter
== "all" ? "active" : "" %>" href="gestion.aspx?f=all">Todos</a></li>
 <li class="nav-item"><a class="nav-link <%= currentFilter
== "pending" ? "active" : "" %>"
href="gestion.aspx?f=pending">Pendientes</a></li>
 <li class="nav-item"><a class="nav-link <%= currentFilter
== "done" ? "active" : "" %>" href="gestion.aspx?f=done">Listos</a></li>
 </ul>
 </div>
 <div class="col-md-6">
 <div class="input-group shadow-sm border rounded-pill
overflow-hidden bg-white">
 <span class="input-group-text border-0 bg-transparent ps-3
text-muted"><i class="fas fa-search"></i></span>
 <input type="text" id="txtSearch" class="form-control
border-0 py-2" placeholder="Buscar cliente o equipo..." onkeyup="doSearch()">
 </div>
 </div>
 </div>
 <div class="card card-table shadow">
 <div class="table-responsive">
 <table class="table table-hover align-middle mb-0"
id="mainTable">
 <thead>
 <tr>
 <th class="ps-4 py-3 text-center" style="width:
80px;">ID</th>
 <th>CLIENTE</th>
<th>EQUIPO</th>
<th class="d-none d-lg-table-cell">DESCRIPCIÓN</th>
 <th class="text-center" style="width:
180px;">ACCIONES</th>
 </tr>
 </thead>
 <tbody>
 <%
 using (SqlConnection conn = new
SqlConnection(connStr))
 {
 string sql = "SELECT * FROM Solicitudes";
 if (currentFilter == "pending") sql += " WHERE
Estado = 'Pendiente'";
 else if (currentFilter == "done") sql += "
WHERE Estado = 'Completado'";
 sql += " ORDER BY ID DESC";
 SqlCommand cmd = new SqlCommand(sql, conn);
 conn.Open();
SqlDataReader r = cmd.ExecuteReader();

if (!r.HasRows) {
 Response.Write("<tr><td colspan='5'
class='text-center py-5 text-muted'>No hay registros en esta
categoría</td></tr>");
 }
while (r.Read())
{
 string st = r["Estado"].ToString();
 string rClass = (st == "Completado") ?
"row-completed" : "";
 string id = r["ID"].ToString();

Response.Write(string.Format("<tr
class='{0}'>", rClass));
 Response.Write(string.Format("<td
class='ps-4 fw-bold text-center text-muted'>#{0}</td>", id));
 Response.Write(string.Format("<td><div
class='fw-bold text-primary'>{0}</div></td>", r["Cliente"]));
 Response.Write(string.Format("<td><span
class='badge bg-light text-dark border'>{0}</span></td>", r["Articulo"]));
 Response.Write(string.Format("<td
class='d-none d-lg-table-cell small'>{0}</td>", r["Descripcion"]));

Response.Write("<td class='text-center'>");

if (st != "Completado") {
 Response.Write(string.Format("<a
href='gestion.aspx?f={0}&done={1}' class='btn btn-success btn-sm rounded-circle
me-2 btn-action' title='Finalizar'><i class='fas fa-check'></i></a>",
currentFilter, id));
 } else {
 Response.Write("<i class='fas
fa-check-double text-success me-2' title='Completado'></i>");
 }
 Response.Write(string.Format("<a
href='ticket.aspx?id={0}' target='_blank' class='btn btn-outline-dark btn-sm
me-2 btn-action' title='Ver Ticket'><i class='fas fa-print'></i></a>", id));
 Response.Write(string.Format("<a
href=\"javascript:confirmDelete('gestion.aspx?f={0}&del={1}')\" class='btn-link
text-danger btn-sm btn-action' title='Eliminar'><i class='fas
fa-trash-alt'></i></a>", currentFilter, id));

Response.Write("</td></tr>");
 }
 }
 %>
 </tbody>
 </table>
 </div>
 </div>
 </div>
 <script>
 function doSearch() {
 let filter =
document.getElementById("txtSearch").value.toUpperCase();
 let rows =
document.getElementById("mainTable").getElementsByTagName("tr");
 for (let i = 1; i < rows.length; i++) {
 let text = rows[i].textContent || rows[i].innerText;
 rows[i].style.display = text.toUpperCase().indexOf(filter) > -1
? "" : "none";
 }
 }
unction confirmDelete(url) {
 if (confirm("⚠️ ¿Estás seguro de que quieres eliminar este registro
de SQL Server?")) {
 window.location.href = url;
 }
 }
 </script>
</body>
</html>
