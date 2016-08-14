<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"
	import="pakiet.*, java.security.MessageDigest, sinan.database.ResultSet"%>

<%@ include file="../../partials/organizerAuth.jsp"%>

<%@ include file="../../partials/header.jsp"%>
<%@ include file="../../partials/menu.jsp"%>

<div class="container">
	<div class="page-header">
		<h1>Anuluj rezerwacje</h1>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">

			<%
			/*
			Strona do anulowania wszystkich rezerwacji wybranego wydarzenia
			*/
				request.setCharacterEncoding("utf-8");

				if (request.getParameter("id") != null) {

					Booking bd = new Booking();
					bd.connect();

					if (bd.cancelAllReservations(request.getParameter("id").toString())) {
						response.sendRedirect("reservations.jsp?id="+request.getParameter("id").toString());
					} else {
			%>
			<div class="alert alert-warning" role="alert">Failed to
				cancel your reservation. Please try again later.</div>
			<%
				}

					bd.disconnect();
			%>

			<%
				} else {
			%>
			<div class="alert alert-warning" role="alert">select
				to cancel the event.</div>
			<%
				}
			%>





		</div>
		<div class="col-md-3"></div>
	</div>
</div>

<%@ include file="../../partials/footer.jsp"%>
