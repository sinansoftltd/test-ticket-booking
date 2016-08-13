<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, java.security.MessageDigest, java.sql.ResultSet"%>

<%@ include file="../../partials/header.jsp" %>	
<%@ include file="../../partials/menu.jsp"%>

<!-- Plik, który wywołuje kod odpowiadający za usuwanie rezerwacji. Zawartość tego pliku nie wyświetli się na ekranie poniewaz
po anulowaniu rezerwacji od razu nastepuje przekierowanie na strone z rezerwacjami -->


	<div class="container">
		<div class="page-header">
		  <h1>Anuluj rezerwację</h1>
		</div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">

				<%
				request.setCharacterEncoding("utf-8");
				
				if(request.getParameter("id")!=null){
					
					BazaDanych bd = new BazaDanych();
					bd.polacz();
					
					ResultSet rs = bd.pobierzRezerwacje(Integer.parseInt(request.getParameter("id").toString()));
					
					String name_db = "";
					String city_db = "";
					String place_db = "";					
					String data_db = "";	
					String price_db = "";
					String tickets_db = "";
					
					if(rs != null && rs.next()){
						name_db = rs.getString("name");
						city_db = rs.getString("city");
						place_db = rs.getString("place");
						price_db = rs.getString("price");						
						data_db = rs.getString("eventDate");
						tickets_db = rs.getString("tickets");
					}
															
					if(request.getParameter("anuluj")!=null){						 
						
						
						int tickets = Integer.parseInt(request.getParameter("tickets"));
						
						if(Integer.parseInt(tickets_db)==tickets){
							if(bd.anulujRezerwacje(Integer.parseInt(request.getParameter("id").toString()))){
								response.sendRedirect("reservations.jsp");
							}else{
								%>
									<div class="alert alert-warning" role="alert">Nie udało się dodać wydarzenia. Spróbuj ponownie później.</div>
								<%
							}	
						}else{
							if(bd.anulujRezerwacje(Integer.parseInt(request.getParameter("id").toString()), tickets)){
								response.sendRedirect("reservations.jsp");
							}else{
								%>
									<div class="alert alert-warning" role="alert">Nie udało się anulować rezerwacji. Spróbuj ponownie później.</div>
								<%
							}	
						}							
						
						
						
					}
					
					bd.rozlacz();
					
					%>
					
					
					<div class="panel panel-default">
					  <div class="panel-heading"><%= name_db %></div>
					  <div class="panel-body">
					    <ul class="list-group">
						    <li class="list-group-item"><b>Miasto: </b><%= city_db %></li>
						    <li class="list-group-item"><b>Miejsce: </b><%= place_db %></li>
						    <li class="list-group-item"><b>Data: </b><%= data_db %></li>
						    <li class="list-group-item"><b>Cena: </b><%= price_db %> zł</li>
						    <li class="list-group-item"><b>Zarezerwowanych biletów: </b><%= tickets_db %></li>
						    <li class="list-group-item">
						    	<form action="user/client/cancelReservation.jsp?id=<%= request.getParameter("id") %>" data-toggle="validator" role="form" method="post">
									<div class="form-group">
										<label for="tickets"><b>Z ilu biletów chcesz zrezygnować?</b></label> 
										<input type="number" class="form-control" id="tickets" name="tickets" required value="1" min="1" max="<%= tickets_db %>">
										<div class="help-block with-errors"></div>
									</div>
									<input type="submit" class="btn btn-primary btn-block" name="anuluj" value="Anuluj rezerwację">
									<a href="user/client/reservations.jsp" class="btn btn-default btn-block">Powrót</a>
								</form>
						    </li>
						  </ul>
					    
					    
					  </div>
					</div>
			<%
				}else{
				%>
					<div class="alert alert-warning" role="alert">Należy wybrać wydarzenie do anulowania.</div>
				<%
				}
			%>

				

				

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>

<%@ include file="../../partials/footer.jsp" %>	