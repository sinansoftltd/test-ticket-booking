<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, java.sql.ResultSet, java.util.Date"%>

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
			<div class="alert alert-info text-center" role="alert"">Aby
				zarezerwować bilet musisz być zalogowany.</div>
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
						<th>Wydarzenie</th>
						<th>Miasto</th>
						<th>Miejsce</th>
						<th>Data</th>
						<th>Ilość biletów</th>
						<th>Cena biletu</th>
						<th>Akcje</th>
					</tr>
				</thead>
				<tbody>
					<%
						BazaDanych bd = new BazaDanych();
						bd.connect();

						ResultSet rs = bd.downloadEvents();
						
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
								out.print("<a href=\"user/client/newMessage.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-info\">Wiadomość</a> ");
							}else{
								out.print("<a href=\"user/client/newMessage.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-info\" disabled>Wiadomość</a> ");
							}
							if(Integer.parseInt(rs.getString("tickets")) == 0){
								out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\" disabled>Brak biletów</a>");
							}else if(today.after(event)){
								out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\" disabled>Zarezerwuj</a>");
							}else{
								if(canBook){
									out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\">Zarezerwuj</a>");
								}else{
									out.print("<a href=\"book.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\" disabled>Zarezerwuj</a>");
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