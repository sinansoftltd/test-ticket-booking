<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"
	import="pakiet.*, java.security.MessageDigest, sinan.database.ResultSet"%>

<%@ include file="../../partials/clientAuth.jsp"%>

<%@ include file="../../partials/header.jsp"%>
<%@ include file="../../partials/menu.jsp"%>


<!-- 
Plik który wywołuje kod odpowiedzialny za usuwanie wiadomości. Podobnie jak w przypadku anulowania rezerwacji zaraz po usunieciu wiadomosci 
jest wyswietlana strona z lista wiadomosci.
 -->


<div class="container">
	<div class="page-header">
		<h1>Usuń wiadomość</h1>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">

			<%
				request.setCharacterEncoding("utf-8");

				if (request.getParameter("id") != null) {

					Booking bd = new Booking();
					bd.connect();

					if (bd.removeMessage(request.getParameter("id").toString())) {
						response.sendRedirect("messages.jsp");
					} else {
			%>
			<div class="alert alert-warning" role="alert">Failed to
				delete the messages. Please try again later.</div>
			<%
				}

					bd.disconnect();
			%>

			<%
				} else {
			%>
			<div class="alert alert-warning" role="alert">select
				the message to delete.</div>
			<%
				}
			%>





		</div>
		<div class="col-md-3"></div>
	</div>
</div>

<%@ include file="../../partials/footer.jsp"%>
