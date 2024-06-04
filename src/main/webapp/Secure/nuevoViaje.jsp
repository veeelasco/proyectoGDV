<%@page import="jakarta.persistence.Query"%>
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager"%>
<%@page import="java.time.LocalDate"%>
<%@page import="modelo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Buscar Hotel</title>
<%

	HttpSession a = request.getSession();
	Usuario usuario = (Usuario) a.getAttribute("usuario");
	
	EntityManager em = HibernateUtils.getEmf().createEntityManager();
	
	Query query = em.createQuery("SELECT u.tema, u.sesionActiva FROM Usuario u WHERE u.id = :idUsuario");
	query.setParameter("idUsuario", usuario.getId_usuario());

	Object[] resultado = (Object[]) query.getSingleResult();

	Boolean tema = (Boolean) resultado[0];
	Boolean sesion_Activa = (Boolean) resultado[1];
	
	usuario.setTema(tema);
	usuario.setSesionActiva(sesion_Activa);
	
	System.out.println("Informacion usuario actual: "+usuario.toString());

	if (usuario.getTema()==true) {
%>
	    <link rel="stylesheet" href="../Styles/Busqueda_Viaje/cssBusquedaViaje_Oscuro.css">
<%
	} else {
%>
	    <link rel="stylesheet" href="../Styles/Busqueda_Viaje/cssBusquedaViaje_Claro.css">
<%    
	}
%>
	<script src="../JavaScript/nuevoViaje.js"></script>
</head>
<body>
<%
	if (usuario.getSesionActiva() == false) {
%>
		<form name="tema" action="../LoginController" method="POST">
			<input type="hidden" name="opcion" value="cambiar_tema">
	
			<div class="Contenedor_SesionCerrada">
				<p id="Titulo">UPS</p>
				<p id="Texto">
					<img id="imgAdvertencia" src="../Resources/advertencia.png">
					Tu sesión está cerrada 
					<img id="imgAdvertencia" src="../Resources/advertencia.png">
				</p>
				<p id="Texto">Inicia esión otra vez.</p>
				<a id="Boton_Loger" href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='Loger';document.tema.submit();">Iniciar Sesion</a>
			</div>
		</form>
<%
	} else {

%>
		<header id="Cabecero">
			<form id="form_cabecero" action="LoginController?opcion=perfil" method="post">
				<%a.setAttribute("usuario", usuario);%>
				<input id="Cancelar" type="submit" value="cancelar">
			</form>
		</header>
		
		<div id="Contenedor_Principal">
		
		    <div class="Contenedor_Titulo">
		        <h1 class="Titulo">Buscar un hotel</h1>
		        <h3 class="Titulo">(El nombre de las ciudades deben ser en inglés)</h3>
		    </div> 
		     
		    <div class="Contenedor_Busqueda">
		        <form name="buscar" action="../LoginController" method="post" onsubmit="return validateDates()">
		            <input type="hidden" name="opcion" value="buscarHotel">
		            
		            <label class="Textos" for="origen">Origen</label>
		            <input class="Botones" type="text" name="origen" id="origen" required="required">
		            
		            <label class="Textos" for="destino">¿A dónde quieres viajar?</label>
		            <input class="Botones" type="text" name="destino" id="destino" required="required">
		            
		            <label class="Textos" >Filtros de búsqueda:</label>
		            <label class="Textos" for="fechaEntrada">Fecha de entrada</label>
		            <input class="Botones" type="date" name="fechaEntrada" id="fechaEntrada" required="required" min="<%= LocalDate.now()%>" value="<%=LocalDate.now()%>">
		            
		            <label class="Textos" for="fechaSalida">Fecha de salida</label>
		            <input class="Botones" type="date" name="fechaSalida" id="fechaSalida" required="required" min="<%= LocalDate.now()%>" >
		            
		            <label class="Textos" for="numeroPersonas">Número de personas (1 Habitacion)</label>
		            <input class="Botones" type="number" name="numeroPersonas" id="numeroPersonas" min="1" max="5" required="required" value="1">
		            
<%
					a.setAttribute("usuario", usuario); 
%>
		            <input id="busca" type="submit" value="Buscar">
		            
		        </form>
		    </div>
		</div>

<%
	}
%>
</body>
</html>
