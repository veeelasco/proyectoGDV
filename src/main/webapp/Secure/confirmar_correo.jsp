<%@page import="controlador.LoginController"%>
<%@page import="util.EmailValidator"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="modelo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <jsp:useBean id="usuario" scope="request" class="modelo.Usuario"/>

<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="../Styles/Confirmar_Correo/cssConfirmar_Correo_Claro.css">
<meta charset="UTF-8">
<title>Verificar correo</title>

</head>
<body>
	<c:if test="${not empty error}">
		    <p style="color: red;">${error}</p>
	</c:if>
	
<form name="register" action="LoginController" method="post">

	<input type="hidden" name="opcion" value="verificarCorreo">

	<label>Codigo de verificación</label><br>
	<input id="cod_verificacion" name="cod_verificacion" type="text"><br>
	<button id="btnVerificar" type="submit" >Verificar correo</button>
</form>

</body>
</html>