<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"
	import="pakiet.*, java.security.MessageDigest, java.sql.ResultSet"%>

<%@ include file="../../partials/organizerAuth.jsp"%>

<%@ include file="../../partials/header.jsp"%>
<%@ include file="../../partials/menu.jsp"%>

<div class="container">
	<div class="page-header">
		<h1>Anuluj rezerwację</h1>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">

			<%
			/*
			Strona wywołująca kod anulowania rezerwacji.
			*/
			
				request.setCharacterEncoding("utf-8");

				if (request.getParameter("id") != null) {

					BazaDanych bd = new BazaDanych();
					bd.polacz();			
					
					ResultSet rs = bd.pobierzRezerwacje(Integer.parseInt(request.getParameter("id").toString()));

					int id = 0;

					if (rs != null && rs.next()) {
						id = rs.getInt("id");
					}

					if (bd.anulujRezerwacje(Integer.parseInt(request.getParameter("id").toString()))) {
						response.sendRedirect("reservations.jsp?id="+id);
					} else {
			%>
			<div class="alert alert-warning" role="alert">Nie udało się
				anulować rezerwacji. Spróbuj ponownie później.</div>
			<%
				}

					bd.rozlacz();
			%>

			<%
				} else {
			%>
			<div class="alert alert-warning" role="alert">Należy wybrać
				wydarzenie do anulowania.</div>
			<%
				}
			%>





		</div>
		<div class="col-md-3"></div>
	</div>
</div>

<%@ include file="../../partials/footer.jsp"%>
