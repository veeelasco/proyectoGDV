
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.HotelBD"%>
<%@page import="modelo.Direccion"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.FareDetailsBySegment"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.TravelerPricing"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.amadeus.referencedata.Locations"%>
<%@page import="com.amadeus.resources.Location"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.SearchSegment"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.Itinerary"%>
<%@page import="com.amadeus.Shopping"%>
<%@page import="com.amadeus.Params"%>
<%@page import="com.amadeus.Amadeus"%>
<%@page import="com.amadeus.resources.FlightOfferSearch"%>
<%@page import="modelo.Usuario"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
//Sustituir Atributos por getters de objetos
    Amadeus amadeus=(Amadeus)request.getAttribute("sesionAmadeus");
	String fechaEntrada=(String)request.getAttribute("fechaEntrada3");
	String fechaSalida=(String)request.getAttribute("fechaSalida3");
	String numeroPersonas=(String)request.getAttribute("numeroPersonas3");
	
	String codigoPaisOrigen=(String)request.getAttribute("codigoIATAPaisOrigen2");
	String codigoCiudadOrigen= (String) request.getAttribute("codigoIATACiudadOrigen2");
	String codigoPaisDestino=(String)request.getAttribute("codigoIATAPaisDestino2");
    String codigoCiudadDestino=(String)request.getAttribute("codigoIATACiudadDestino2");
	
	
	Direccion direccion=(Direccion)request.getAttribute("direccion_Creada");
	HotelBD hotel=(HotelBD)request.getAttribute("hotel_Creada");
	Habitacion habitacion=(Habitacion)request.getAttribute("habitacion_Creada");
	
	request.getSession().setAttribute("direccion_Final",direccion);
	request.getSession().setAttribute("hotel_Final",hotel);
	request.getSession().setAttribute("habitacion_Final",habitacion);
	
	
	//Obtiene la sesión actual
	HttpSession sessionA=request.getSession();
	//Obtiene los datos del usuario almacenados en la sesión
	Usuario usuario = (Usuario) sessionA.getAttribute("usuario");
	System.out.println("Informacion usuario actual: "+usuario.toString());
	
	Location[] locations= amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", codigoCiudadOrigen)
				.and("countryCode", codigoPaisOrigen));
	    		//De momento trabajo con MAD=Aeropuert Adolfo Suarez Barajas,LHR=UK,TXL=BER(Berlin)
	    		//La API busca en ingles
	    		
   Location[] locationsDestino = amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", codigoCiudadDestino)
				.and("countryCode", codigoPaisDestino));
   	
	   FlightOfferSearch[] flightOffers = amadeus.shopping.flightOffersSearch.get(
            Params.with("originLocationCode", codigoCiudadOrigen)
                    .and("destinationLocationCode", codigoCiudadDestino)
                    .and("departureDate", fechaEntrada)
                    .and("returnDate", fechaSalida)
                    .and("adults", numeroPersonas)
                    .and("nonStop", true)
                    .and("max", 10));
   		//System.out.println(flightOffers.length); 
	%>
                   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Viajes: avion</title>
</head>
	<header>
		<form action="LoginController?opcion=perfil" method="post">
			<%sessionA.setAttribute("usuario", usuario); %>
			<input type="submit" value="cancelar">
		
		</form>
	</header>	
<body>
	<%
	try{
		
	
	if(flightOffers[0].getId()!=null){%>
		
		<% 
		for(int j=0;j<flightOffers.length;j++){
		try{
			
		
			Itinerary[]itineraries=flightOffers[j].getItineraries();
			TravelerPricing[]pricings=flightOffers[j].getTravelerPricings();
			FareDetailsBySegment[]bySegments=pricings[0].getFareDetailsBySegment();

		%>
		<table>
		<tr style="border: 2px; border-style: solid; border-color: black;">
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">Id vuelo</th>				<!-- No incluir en bd -->
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">Ultima fecha para comprar</th>	<!-- No incluir en bd -->
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">NºAsientos disponibles</th>	<!-- No incluir en bd -->					
			<th rowspan="1" colspan="10" style="border: 2px; border-style: solid; border-color: black;">Ida</th>
			<th rowspan="1" colspan="10" style="border: 2px; border-style: solid; border-color: black;">Vuelta</th>					<!-- Puede no haber vuelta-->
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">Precio</th>
			<!-- incluir Datos del asiento por cada viajero o unico viajero(pensarlo) -->
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">

			<th colspan="6" style="border: 2px; border-style: solid; border-color: black;">Salida</th>
			<th colspan="4" style="border: 2px; border-style: solid; border-color: black;">Llegada</th>
			<th colspan="6" style="border: 2px; border-style: solid; border-color: black;">Salida</th>
			<th colspan="4" style="border: 2px; border-style: solid; border-color: black;">Llegada</th>
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">

			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Duracion</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Origen</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Salida</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Compañia Aerea</th>
			
			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Destino</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Llegada</th>
			
			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Duracion</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Origen</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Salida</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Compañia Aerea</th>
			
			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Destino</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Llegada</th>
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[j].getId() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[j].getLastTicketingDate() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[j].getNumberOfBookableSeats() %></td>
			<%for(int x=0;x<2;x++){
				SearchSegment[]searchSegments=itineraries[x].getSegments();
				
				//System.out.println("Itinerario "+x +": "+itineraries[x].toString());
				//System.out.println("segmento "+x +": "+searchSegments[0].toString());
				if(x==0){
					%>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locations[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=itineraries[x].getDuration() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locations[0].getAddress().getCityName() %> </td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getAt() %></td>					
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getCarrierCode() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locationsDestino[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=codigoCiudadDestino %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getAt() %></td>
					<% 
				}else if(x>0){
				%>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locationsDestino[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=itineraries[x].getDuration() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locationsDestino[0].getAddress().getCityName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getAt() %></td>		
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getCarrierCode() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locations[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locations[0].getAddress().getCityCode() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getAt() %></td>
			<%}
			} %>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[0].getPrice().getTotal()+"/"+flightOffers[0].getPrice().getCurrency()%></td>
		</tr>
		<tr>
			<th rowspan="3" colspan="4" style="border: 2px; border-style: solid; border-color: black;">Info Asiento</th>
		</tr>
		
			<tr>
				<th style="border: 2px; border-style: solid; border-color: black;">id viajero</th>
				<th style="border: 2px; border-style: solid; border-color: black;">tipo Viajero</th>
				<th style="border: 2px; border-style: solid; border-color: black;">Precio billete</th>
				<th style="border: 2px; border-style: solid; border-color: black;">Clase</th>
			</tr>
			<tr>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=pricings[0].getTravelerId() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=pricings[0].getTravelerType() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=pricings[0].getPrice().getTotal()+"/ "+pricings[0].getPrice().getCurrency() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=bySegments[0].getCabin() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;">
					<form name="guardarOfertaViaje"
						action="LoginController?opcion=guardarOfertaViaje" method="post">
						<input type="hidden" name="aeropuertoOrigen" value="<%=locations[0].getName()%>">
						<input type="hidden" name="ciudadOrigen" value="<%=locations[0].getAddress().getCityName()%>">
						<input type="hidden" name="companiaAerea" value="<%=locations[0].getName()%>">
						<input type="hidden" name="ciudadDestino" value="<%=locationsDestino[0].getAddress().getCityName()%>">
						<input type="hidden" name="aeropuertoDestino" value="<%=locationsDestino[0].getName()%>">
						<input type="hidden" name="tipoViajero" value="<%=pricings[0].getTravelerType()%>">
						<input type="hidden" name="precioMedio" value="<%=pricings[0].getPrice().getTotal()%>">
						<input type="hidden" name="claseCabina" value="<%=bySegments[0].getCabin()%>">
						
						<input type="submit" value="Guardar">
					</form>
				</td>
			</tr>
		</table>
		<% 
		}catch(ArrayIndexOutOfBoundsException e){
			System.out.println("No hay mas viajes");
			break;
		}
		}	
		}
	}catch( ArrayIndexOutOfBoundsException e){
	System.out.println("NO HAY VUELOS DISPONIBLES");
	//response.sendRedirect("Secure/nuevoViaje.jsp");
	%>
	
	<h2>¿Quieres guardar el viaje sin vuelos?</h2>
	<form action="LoginController?opcion=guardarOfertaViaje" method="post">
		<input type="submit" value="Guardar Viaje">
	</form>
	<form action="LoginController?opcion=perfil" method="post">
		<%
		sessionA.setAttribute("usuario",usuario);
		%>
		<input type="submit" value="volver">
	</form>
	
	<script>alert('NO HAY VUELOS DISPONIBLES PARA LA CIUDAD\n ${param.destino}')</script>
	<%
	}
		%>
	
</body>
</html>