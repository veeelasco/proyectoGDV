<%@page import="java.time.LocalDate"%>
<%@page import="modelo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
// Obtiene la sesión actual
HttpSession a = request.getSession();
// Obtiene los datos del usuario almacenados en la sesión
Usuario usuario = (Usuario) a.getAttribute("usuario");
usuario.getTema();
System.out.println("Informacion usuario actual: "+usuario.toString());

if (usuario.getTema()==true) {
%>
	<link rel="stylesheet" href="../Styles/Busqueda_Viaje/cssBusquedaViaje_Oscuro.css">
<%
}
else {
%>
	<link rel="stylesheet" href="../Styles/Busqueda_Viaje/cssBusquedaViaje_Claro.css">
<%	
}
%>
	
</head>
<body>

	<header>
		<form action="LoginController?opcion=perfil" method="post">
			<%a.setAttribute("usuario", usuario); %>
			<input type="submit" value="cancelar">
		
		</form>
	</header>	
	<div id="Contenedor_Principal">
	    <div class="Contenedor_Titulo">
	        <h1>Buscar un hotel</h1>
	        <h3>(El nombre de las ciudades deben ser en inglés)</h3>
	    </div>  
	    <div class="Contenedor_Busqueda">
	        <form name="buscar" action="../LoginController" method="post">
	            <input type="hidden" name="opcion" value="buscarHotel">
	            <label for="origen">Origen</label>
	            <input type="text" name="origen" id="origen" required="required">
	            <label for="destino">¿A dónde quieres viajar?</label>
	            <input type="text" name="destino" id="destino" required="required">
	            <label>Filtros de búsqueda:</label>
	            <label for="fechaEntrada">Fecha de entrada</label>
	            <input type="date" name="fechaEntrada" id="fechaEntrada" required="required" min="<%= LocalDate.now()%>">
	            <label for="fechaSalida">Fecha de salida</label>
	            <input type="date" name="fechaSalida" id="fechaSalida" required="required" min="<%= LocalDate.now()%>" >
	            <label for="numeroPersonas">Número de personas(1 Habitacion)</label>
	            <input type="number" name="numeroPersonas" id="numeroPersonas" min="1" max="5" required="required" value="1">
	            <%a.setAttribute("usuario", usuario); %>
	            <input id="busca" type="submit" value="Buscar">
	        </form>
	    </div>
	</div>
</body>
</html>