<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, java.sql.ResultSet"%>

<%@ include file="../../partials/clientAuth.jsp"%>

<%@ include file="../../partials/header.jsp"%>
<%@ include file="../../partials/menu.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('#dataTable').DataTable({
            "language": {
                "url": "js/Polish.json"
            }
        });
	});
	
	var idToDelete = 0;
	
	function confirmDelete(id){
		idToDelete = id;
		$('#confirmDeleteModal').modal();
	}
	
	function confirmCancel(id){
		idToDelete = id;
		$('#confirmCancelModal').modal();
	}
	
	function deleteEvent(){
		location.href = "user/organizer/cancelReservation.jsp?id="+idToDelete;
	}
	
	function cancelReservations(){
		location.href = "user/organizer/cancelReservations.jsp?id="+idToDelete;
	}
</script>

<%
/*
Strona do wyświetlania rezerwacji wybranego wydarzenia
*/
BazaDanych bd = new BazaDanych();
bd.connect();

ResultSet rs = bd.getEvent(Integer.parseInt(request.getParameter("id")));
rs.next();

String eventName = rs.getString("name");
%>

<div class="container">
	<div class="page-header">
		  <h1>Rezerwacje <small><%= eventName %></small></h1>
		</div>	
	<div class="row">
		<div class="col-md-12">
			<a class="btn btn-info" href="user/client/newMessage.jsp?eventId=<%= request.getParameter("id") %>">Wyślij wiadomość do wszystkich</a>
			<button class="btn btn-warning" onclick="confirmCancel(<%= request.getParameter("id") %>)">Anuluj wszystkie rezerwacje</button>
		</div>
	</div>
	<div class="row" style="margin-top: 40px;">
		<div class="col-md-12">

			<table id="dataTable" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>Użytkownik</th>
						<th>Ilość biletów</th>
						<th>Akcje</th>
					</tr>
				</thead>				
				<tbody>
					<%	
										
					rs = bd.getReservationsEvents(Integer.parseInt(request.getParameter("id")));
					
					while(rs.next()){
						out.print("<tr>");
						
						out.print("<td>"+rs.getString("email")+"</td>");
						out.print("<td>"+rs.getString("tickets")+"</td>");
						out.print("<td>");
						//out.print("<a href=\"user/organizer/editEvent.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\">Edytuj</a> ");
						//out.print("<a href=\"user/organizer/cancelReservation.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-danger\">Anuluj</a>");
						out.print("<a href=\"user/client/newMessage.jsp?id="+rs.getInt("userId")+"&eventId="+request.getParameter("id")+"\" class=\"btn btn-info\">Wiadomość</a> ");
						out.print("<button class=\"btn btn-danger\" onclick=\"confirmDelete("+rs.getInt("reservationId")+")\">Anuluj</button>");
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

<div class="modal fade" tabindex="-1" role="dialog" id="confirmDeleteModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Anuluj rezerwację</h4>
      </div>
      <div class="modal-body">
        <p>Na pewno anulować wybraną rezerwację?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Nie</button>
        <button type="button" class="btn btn-danger" onclick="deleteEvent()">Tak</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" tabindex="-1" role="dialog" id="confirmCancelModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Anuluj wszystkie rezerwacje</h4>
      </div>
      <div class="modal-body">
        <p>Na pewno anulować wszystkie rezerwacje?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Nie</button>
        <button type="button" class="btn btn-danger" onclick="cancelReservations()">Tak</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%@ include file="../../partials/footer.jsp"%>