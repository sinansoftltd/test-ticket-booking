<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, sinan.database.ResultSet"%>

<%@ include file="../../partials/organizerAuth.jsp"%>

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
		  <h1>My events</h1>
		</div>
	<div class="row">
		<div class="col-md-12">
			<a class="btn btn-primary" href="user/organizer/addEvent.jsp">Add event</a>
		</div>
	</div>
	
	<%
	/*
	Strona do wyświetlania wydarzeń zalogowanego organizatora. 
	*/
	Booking bd = new Booking();
	bd.connect();
	
	if(request.getParameter("deleteId")!=null){
		if(bd.removeEvent(request.getParameter("deleteId").toString())){
			%>
			
					<div class="alert alert-success alert-dismissible" role="alert" style="margin-top: 40px;">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						The event has been removed
					</div>
				
			<%
		}else{
			%>
			
					<div class="alert alert-warning alert-dismissible" role="alert" style="margin-top: 40px;">
						<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						Failed to delete event. Please try again later.
					</div>
				
			<%
		}
	}
	%>
	
	<div class="row" style="margin-top: 40px;">
		<div class="col-md-12">

			<table id="dataTable" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>Wydarzenia</th>
						<th>Miasto</th>
						<th>Miejsce</th>
						<th>Data</th>
						<th>Bilety</th>
						<th>Cena</th>
						<th>Akcje</th>
					</tr>
				</thead>				
				<tbody>
					<%				
					
					ResultSet rs = bd.getEvents(session.getAttribute("userId").toString());
					
					while(rs.next()){
						out.print("<tr>");
						
						out.print("<td>"+rs.getString("name")+"</td>");
						out.print("<td>"+rs.getString("city")+"</td>");
						out.print("<td>"+rs.getString("place")+"</td>");
						out.print("<td>"+rs.getString("eventDate")+"</td>");
						out.print("<td>"+rs.getString("tickets")+"</td>");
						out.print("<td>"+rs.getString("price")+" zł</td>");
						out.print("<td>");
						out.print("<a href=\"user/organizer/reservations.jsp?id="+rs.getString("id")+"\" class=\"btn btn-info\">Reservations</a> ");
						out.print("<a href=\"user/organizer/editEvent.jsp?id="+rs.getString("id")+"\" class=\"btn btn-primary\">Edit</a> ");
						out.print("<button class=\"btn btn-danger\" onclick=\"confirmDelete("+rs.getString("id")+")\">Delete</button>");
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
        <h4 class="modal-title">Delete event</h4>
      </div>
      <div class="modal-body">
        <p>Really delete the selected event?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-danger" onclick="deleteEvent()">Delete</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%@ include file="../../partials/footer.jsp"%>