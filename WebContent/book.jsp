<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, java.security.MessageDigest, java.sql.ResultSet"%>

<%@ include file="partials/header.jsp" %>	
<%@ include file="partials/menu.jsp"%>

	<div class="container">
		<div class="page-header">
		  <h1>Rezerwacja biletu</h1>
		</div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">

				<%
				/*
				Strona z formularzem rezerwacji biletów
				*/
				request.setCharacterEncoding("utf-8");
				
				if(request.getParameter("id")!=null){
					
					BazaDanych bd = new BazaDanych();
					bd.connect();
					
					ResultSet rs = bd.getEvent(Integer.parseInt(request.getParameter("id").toString()));
					
					String name_db = "";
					String city_db = "";
					String place_db = "";
					String tickets_db = "";					
					String data_db = "";	
					String price_db = "";
					
					if(rs != null && rs.next()){
						name_db = rs.getString("name");
						city_db = rs.getString("city");
						place_db = rs.getString("place");
						tickets_db = rs.getString("tickets");
						price_db = rs.getString("price");						
						data_db = rs.getString("eventDate");
					}
										
					if(request.getParameter("book")!=null){
						
						
						int tickets = Integer.parseInt(request.getParameter("tickets"));
						
						
						if(bd.bookTickets(Integer.parseInt(request.getParameter("id").toString()), Integer.parseInt(session.getAttribute("userId").toString()), tickets)){
							response.sendRedirect("user/client/reservations.jsp");
						}else{
							%>
								<div class="alert alert-warning" role="alert">Nie udało się dodać wydarzenia. Spróbuj ponownie później.</div>
							<%
						}			
						
						
						
					}
					
					bd.disconnect();
					
					%>
					
					
					<div class="panel panel-default">
					  <div class="panel-heading"><%= name_db %></div>
					 
					    <ul class="list-group">
						    <li class="list-group-item"><b>City: </b><%= city_db %></li>
						    <li class="list-group-item"><b>Place: </b><%= place_db %></li>
						    <li class="list-group-item"><b>Data: </b><%= data_db %></li>
						    <li class="list-group-item"><b>Price: </b><%= price_db %> zł</li>
						    <li class="list-group-item"><b>Number of tickets: </b><%= tickets_db %></li>
						    <li class="list-group-item">
						    	<form action="book.jsp?id=<%= request.getParameter("id") %>" data-toggle="validator" role="form" method="post">
									<div class="form-group">
										<label for="tickets"><b>How many tickets you want to reserve?</b></label>
										<input type="number" class="form-control" id="tickets" name="tickets" required value="1" min="1" max="<%= tickets_db %>">
										<div class="help-block with-errors"></div>
									</div>
									<input type="submit" class="btn btn-primary btn-block" name="book" value="Book">
								</form>
						    </li>
						  </ul>				    
					 
					</div>
			<%
				}else{
				%>
					<div class="alert alert-warning" role="alert">Select the event to book.</div>
				<%
				}
			%>

				

				

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>

<%@ include file="partials/footer.jsp" %>	