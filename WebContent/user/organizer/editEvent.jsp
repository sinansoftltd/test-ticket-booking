<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="UTF-8" import="pakiet.*, java.security.MessageDigest, java.util.Date, java.sql.Timestamp, sinan.database.ResultSet"%>

<%@ include file="../../partials/organizerAuth.jsp"%>

<%@ include file="../../partials/header.jsp" %>	
<%@ include file="../../partials/menu.jsp"%>

	<div class="container">	
		<div class="page-header">
		  <h1>Edytuj wydarzenie</h1>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">

				<%
				
				/*
				Strona z formularzem edycji wydarzenia
				*/
				
				request.setCharacterEncoding("utf-8");
				
				if(request.getParameter("id")!=null){
					
					Booking bd = new Booking();
					bd.connect();
					
					ResultSet rs = bd.getEvent(request.getParameter("id").toString());
					
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
						
						data_db = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("eventDate"));
						data_db = data_db.replace(" ", "T");
					}
										
					if(request.getParameter("zapisz")!=null){						 
						
						
						String name = request.getParameter("name");
						String city = request.getParameter("city");
						String place = request.getParameter("place");
						int tickets = Integer.parseInt(request.getParameter("tickets"));
						double price = Double.parseDouble(request.getParameter("price"));
						
						String data_string = request.getParameter("date");		
						data_string = data_string.replace("T", " ");
						
						Date data = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(data_string);
						Timestamp eventDate = new Timestamp(data.getTime());
						
						if(bd.editEvent(request.getParameter("id").toString(), name, city, place, eventDate, tickets, price)){
							response.sendRedirect("events.jsp");
						}else{
							%>
								<div class="alert alert-warning" role="alert">Nie udało się dodać wydarzenia. Spróbuj ponownie później.</div>
							<%
						}			
						
						
						
					}
					
					bd.disconnect();
					
					%>
					
					
	
					<form data-toggle="validator" role="form" method="post">					
						<div class="form-group">
							<label for="name">Name</label>
							<input type="text" class="form-control" id="name" name="name" required value="<%= name_db %>">
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<label for="city">City</label>
							<input type="text" class="form-control" id="city" name="city" required value="<%= city_db %>">
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<label for="place">Place</label>
							<input type="text" class="form-control" id="place" name="place" required value="<%= place_db %>">
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<label for="dete">Data</label> 
							<input type="datetime-local" class="form-control" id="date" name="date" required value="<%= data_db %>">
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<label for="price">Ticket price</label>
							<input type="text" class="form-control" id="price" name="price" required pattern="^[0-9]*\.[0-9]{2}$" value="<%= price_db %>">
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<label for="tickets">Number of tickets</label>
							<input type="number" class="form-control" id="tickets" name="tickets" required value="<%= tickets_db %>" min="1">
							<div class="help-block with-errors"></div>
						</div>
						<a href="user/organizer/events.jsp" class="btn btn-default pull-left">Return</a>
						<input type="submit" class="btn btn-primary pull-right" name="zapisz" value="Save">
					</form>
			<%
				}else{
				%>
					<div class="alert alert-warning" role="alert">Select the event for editing.</div>
				<%
				}
			%>

			</div>
			<div class="col-md-4"></div>
		</div>
	</div>

<%@ include file="../../partials/footer.jsp" %>	