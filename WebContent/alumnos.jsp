<%@page import="dao.AlumnoDao"%>
<%@page import="entidad.Alumno"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css"/>
<link rel="stylesheet" type="text/css" href="DataTables/DataTableStyle.css"/>

<%
if (session.getAttribute("login") == null)
{
	response.sendRedirect("login.jsp");	
}
else
{
	if((Boolean)session.getAttribute("login") == false || (Boolean)session.getAttribute("admin") == false)
	{
		response.sendRedirect("login.jsp");	
	}
}
%>

<title>SGA - Alumnos</title>
</head>
<body style="background-color:#000000;">

<form method="post" action="servletLogin">
<div class="container-fluid">
	<div class="row">
		<div class="col-6">
			<h1><font color="#cccccc">S.G.A.</font></h1>
			<h6><font color="#cccccc">(Sistema de Gestion Academica)</font></h6>
		</div>
		<div class="col-6  text-right">
			<font color="#cccccc">
				Usuario: admin <br>
			</font>
			<input type="submit" name="btnSalir" value="Salir">
		</div>
	</div>
</div>
</form>

<div class="container mb-3 mt-3">
	<table id="listado" class="display">
		<thead>
			<tr> 
				<th><font color="#cccccc">Legajo</font></th> 
				<th><font color="#cccccc">Nombre</font></th> 
				<th><font color="#cccccc">Apellido</font></th> 
				<th><font color="#cccccc">DNI</font></th> 
				<th><font color="#cccccc">Genero</font></th> 
				<th><font color="#cccccc">Telefono</font></th> 
				<th><font color="#cccccc">Domicilio</font></th> 
				<th><font color="#cccccc">Nacimiento</font></th> 
				<th><font color="#cccccc">Acciones</font></th> 
			</tr>
		</thead>
		<tbody>
			<%
			AlumnoDao dao = new AlumnoDao();
			ArrayList<Alumno> list = dao.obtenerAlumnos();
			for(Alumno item: list) {
			%>
			<tr>
				<td><%=item.getLegajoA()%></td>
				<td><%=item.getNombre()%></td>
				<td><%=item.getApellido()%></td>
				<td><%=item.getDni()%></td>
				<td><%String genero; if(item.getGenero() == 0){genero="Masculino";} else{genero="Femenino";}%><%=genero%></td>
				<td><%=item.getTelefono()%></td>
				<td><%=item.getDomicilio()%></td>
				<td><%=item.getNacimiento()%></td>
				<td>	
					<form method="post" action="servletAlumno">
					 	<input type="hidden" name="alumnoEdit" value="<%=item.getLegajoA()%>">
					 	<button type="submit" name="btnModificar">
					 		Modificar
					 	</button>
						<%String btnEliminar = "btn" + item.getLegajoA();%>
						<button type="submit" name="btnEliminar" id="<%=btnEliminar%>"> 
							Eliminar
						</button>		
						<%if(!dao.alumnoLibre(item.getLegajoA())){%>
							<script type="text/javascript"> 
							document.getElementById("<%=btnEliminar%>").disabled = true;
							</script>
						<%}%>				
					</form>
				</td>
			</tr>
			<%	
			} 
			%>
		</tbody>
	</table>
</div>
<br> <br> <br> <br>
<form method="post" action="servletAlumno">
	<div class="text-center">
		<input type="submit" name="btnAgregar" value="Registrar Alumno" /> <br> <br> <br> <br> <br> <br>
		<div class="fixed-bottom">
			<input type="submit" name="btnVolver" value="Volver atras"> 
		</div>
	</div>
</form>

<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="DataTables/datatables.min.js"></script>

<script type="text/javascript"> 
$(document).ready( function () {
    $('#listado').DataTable();
} );
$('#listado').DataTable( {
    "language": {
        "url": "DataTables/language.lang"
    }
} );
var table = $('#listado').DataTable();
var data = table
 .order( [ 2, 'asc' ] )
 .draw();
</script>

</body>
</html>