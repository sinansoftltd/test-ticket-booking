<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, sinan.database.ResultSet, java.util.Date"%>

<%@ include file="../../partials/clientAuth.jsp"%>

<%@ include file="../../partials/header.jsp"%>
<%@ include file="../../partials/menu.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		$('#dataTable').DataTable({
			"language" : {
				"url" : "js/Polish.json"
			}
		});
	});
	
	var idToDelete = 0;
	
	function confirmDelete(id){
		idToDelete = id;
		$('#confirmDeleteModal').modal();
	}
	
	function deleteEvent(){
		location.href = "user/client/deleteMessage.jsp?id="+idToDelete;
	}
</script>

<div class="container">
<div class="page-header">
		  <h1>Wiadomości</h1>
		</div>	
	<div class="row">
		<div class="col-md-12">
			<table id="dataTable" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>Sender</th>
						<th>Topic</th>
						<th>Event</th>
						<th>Akcje</th>
					</tr>
				</thead>
				<tbody>
					<%
					/*
					Jest to strona, która wyświetla wiadomości użytkownika
					*/
					
						Booking bd = new Booking();
						bd.connect();

						ResultSet rs = bd.getNews(session.getAttribute("userId").toString());

						while (rs.next()) {
							
							out.print("<tr>");
							
							if(rs.getInt("readed")==0){
								out.print("<td><b>" + rs.getString("email") + "</b></td>");
								out.print("<td><b>" + rs.getString("title") + "</b></td>");
								out.print("<td><b>" + rs.getString("name") + "</b></td>");
							}else{							
								out.print("<td>" + rs.getString("email") + "</td>");
								out.print("<td>" + rs.getString("title") + "</td>");
								out.print("<td>" + rs.getString("name") + "</td>");
							}
							
							out.print("<td>");
							out.print("<a href=\"user/client/message.jsp?id="+rs.getInt("messageId")+"\" class=\"btn btn-info\">Odczytaj</a> ");
							out.print("<button class=\"btn btn-danger\" onclick=\"confirmDelete("+rs.getInt("messageId")+")\">Usuń</button>");
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
        <h4 class="modal-title">Delete message</h4>
      </div>
      <div class="modal-body">
        <p>Really delete the selected message?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-danger" onclick="deleteEvent()">Delete</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%@ include file="../../partials/footer.jsp"%>