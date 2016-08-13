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
	
	function deleteEvent(){
		location.href = "user/organizer/events.jsp?deleteId="+idToDelete;
	}
</script>

<div class="container">
	<div class="page-header">
		  <h1>Moje rezerwacje</h1>
		</div>	
	<div class="row" style="margin-top: 40px;">
		<div class="col-md-12">

			<table id="dataTable" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>Wydarzenie</th>
						<th>Miasto</th>
						<th>Miejsce</th>
						<th>Data</th>
						<th>Ilość biletów</th>
						<th>Do zapłaty</th>
						<th>Akcje</th>
					</tr>
				</thead>				
				<tbody>
					<%	
					
					/*
					Srtona wyświetlająca rezerwacje użytkownika
					*/
					
					BazaDanych bd = new BazaDanych();
					bd.connect();
					
					ResultSet rs = bd.downloadReservationList(Integer.parseInt(session.getAttribute("userId").toString()));
					
					while(rs.next()){
						out.print("<tr>");
						
						out.print("<td>"+rs.getString("name")+"</td>");
						out.print("<td>"+rs.getString("city")+"</td>");
						out.print("<td>"+rs.getString("place")+"</td>");
						out.print("<td>"+rs.getString("eventDate")+"</td>");
						out.print("<td>"+rs.getInt("tickets")+"</td>");
						out.print("<td>"+(rs.getDouble("price")*rs.getInt("tickets"))+" zł</td>");
						out.print("<td>");
						//out.print("<a href=\"user/organizer/editEvent.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-primary\">Edytuj</a> ");
						out.print("<a href=\"user/client/newMessage.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-info\">Wiadomość</a> ");
						out.print("<a href=\"user/client/cancelReservation.jsp?id="+rs.getInt("id")+"\" class=\"btn btn-danger\">Anuluj</a>");
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
        <h4 class="modal-title">Usuń wydarzenie</h4>
      </div>
      <div class="modal-body">
        <p>Na pewno usunąć wybrane wydarzenie?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Anuluj</button>
        <button type="button" class="btn btn-danger" onclick="deleteEvent()">Usuń</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%@ include file="../../partials/footer.jsp"%>