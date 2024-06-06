<%@page import="controlador.LoginController"%>
<%@page import="util.EmailValidator"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="modelo.Usuario"%>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <jsp:useBean id="usuario" scope="request" class="modelo.Usuario"/>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Verificar correo</title>

	<style>
		body {
		    background-color: #f0f0f0;
		    font-family: Arial, sans-serif;
		    color: #333;
		}
		#Cabecero {
		    background-color: #ffffff;
		    padding: 10px;
		    text-align: right;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}
		
		#form_cabecero {
		    display: inline;
		}
		
		#Cancelar {
		    background-color: #4CAF50;
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    text-align: center;
		    text-decoration: none;
		    font-size: 16px;
		    cursor: pointer;
		    border-radius: 4px;
		}
		
		#Cancelar:hover {
		    background-color: #45a049;
		}
		.Contenedor_Todo {
		    width: 25%;
		    margin: 10% auto;
		    padding: 20px;
		    background-color: #fff;
		    border: 1px solid #ddd;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		    border-radius: 5px;
		}
		
		.Contenedor_Error {
		    margin-bottom: 20px;
		}
		
		#Texto_Error {
		    color: red;
		    font-weight: bold;
		    text-align: center;
		}
		
		.Contenedor_Verificacion {
		    margin-bottom: 20px;
		}
		
		#Texto_Encavecado {
		    display: block;
		    margin-bottom: 10px;
		    font-size: x-large;
		    color: #333;
		    font-weight: bolder;
		    text-align: center;
		}
		
		#cod_verificacion {
		    width: 100%;
		    padding: 10px;
		    margin-bottom: 20px;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    font-size: medium;
		    box-sizing: border-box;
		}
		
		#btnVerificar {
		    display: inline-block;
		    width: 100%;
		    padding: 10px;
		    background-color: #4caf50;
		    color: #fff;
		    border: none;
		    border-radius: 4px;
		    font-size: medium;
		    cursor: pointer;
		    text-align: center;
		    transition: background-color 0.3s;
		}
		
		#btnVerificar:hover {
		    background-color: #45a049;
		}
	</style>

</head>
<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada confirmar_correo");
%>
	<header id="Cabecero">
		<form id="form_cabecero" action="LoginController?opcion=Loger" method="post">
			<input id="Cancelar" type="submit" value="cancelar">
		
		</form>
	</header>
	<div class="Contenedor_Todo">
		<div class="Contenedor_Error">
			<c:if test="${not empty error}">
			    <p id="Texto_Error" style="color: red;">${error}</p>
			</c:if>
			
		</div>
		
		<div class="Contenedor_Verificacion">
		
			<form name="register" action="LoginController" method="post">
			
				<input type="hidden" name="opcion" value="verificarCorreo">
			
				<label id="Texto_Encavecado">Código de verificación</label>
				<label>Se ha enviado un codigo de verificación a tu correo</label>
				
				<input id="cod_verificacion" name="cod_verificacion" type="text">
				
				<button id="btnVerificar" type="submit" >Verificar correo</button>
				
			</form>
			
		</div>
	</div>

</body>
</html>