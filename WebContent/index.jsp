<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, sinan.database.ResultSet, java.util.Date"%>

<%@ include file="partials/header.jsp"%>
<%@ include file="partials/menu.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('#dataTable').DataTable({
			"language" : {
				"url" : "js/Polish.json"
			}
		});
	});
</script>

<div class="container">
	<%
	/*
	Strona główna aplikacji. Wyświetla listę wszystkich dostępnych w systemie wydarzeń
	*/
	
		boolean canBook = true;
		if (session.getAttribute("userId") == null) {
			canBook = false;
	%>
	<div class="row">
		<div class="col-md-12">
			<div class="alert alert-info text-center" role="alert"">To book a ticket, you must be logged in.</div>
		</div>
	</div>
	<%
		}
	%>
	<div class="row">
		<div class="col-md-12">
			<table id="dataTable" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>Event</th>
						<th>City</th>
						<th>Place</th>
						<th>Data</th>
						<th>Tickets #</th>
						<th>Ticket price</th>
						<th>Akcje</th>
					</tr>
				</thead>
				<tbody>
					<%
						Booking bd = new Booking();
						bd.connect();

						ResultSet rs = bd.getEvents();

						Date today = new Date();

						while (rs.next()) {

							Date event = rs.getDate("eventDate");

							out.print("<tr>");

							out.print("<td>" + rs.getString("name") + "</td>");
							out.print("<td>" + rs.getString("city") + "</td>");
							out.print("<td>" + rs.getString("place") + "</td>");
							out.print("<td>" + rs.getString("eventDate") + "</td>");
							out.print("<td>" + rs.getString("tickets") + "</td>");
							out.print("<td>" + rs.getString("price") + " zł</td>");
							out.print("<td>");
							if(canBook){
								out.print("<a href=\"user/client/newMessage.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-info\">Message</a> ");
							}else{
								out.print("<a href=\"user/client/newMessage.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-info\" disabled>Message</a> ");
							}
							if(Integer.parseInt(rs.getString("tickets")) == 0){
								out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\" disabled>No tickets</a>");
							}else if(today.after(event)){
								out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\" disabled>Book</a>");
							}else{
								if(canBook){
									out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\">Book</a>");
								}else{
									out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\" disabled>Book</a>");
								}
							}
							out.print("</td>");

							out.print("</tr>");
						}

						bd.disconnect();
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>

<%@ include file="partials/footer.jsp"%>