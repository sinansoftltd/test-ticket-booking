<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="UTF-8" import="pakiet.*, java.security.MessageDigest, java.util.Date, java.sql.Timestamp, java.sql.ResultSet"%>

<%@ include file="../../partials/clientAuth.jsp"%>

<%@ include file="../../partials/header.jsp" %>	
<%@ include file="../../partials/menu.jsp"%>

	<div class="container">	
		<div class="page-header">
		  <h1>Send a message</h1>
		</div>
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">

				<%
				/*
				Strona z formularzem wysyłania wiadomości 
				*/
				
				request.setCharacterEncoding("utf-8");
				
				Booking bd = new Booking();
				bd.connect();
				
				int recipient_id = 0;
				String event_name = "";
				int event_id = 0;
				String recipient_email = "";
				
				String re_title = "";
				
				if(request.getParameter("eventId")==null){
				
					if(request.getParameter("messageId") == null){
						ResultSet rs = bd.getEvent(request.getParameter("id"));
						rs.next();
						
						recipient_id = rs.getInt("user_id");
						event_name = rs.getString("name");
						event_id = rs.getInt("id");
						recipient_email = bd.getEmail(recipient_id);
					}else{
						ResultSet rs = bd.reply(Integer.parseInt(request.getParameter("messageId")));
						rs.next();
						
						recipient_id = rs.getInt("user_id");
						event_name = rs.getString("name");
						event_id = rs.getInt("id");
						re_title = "RE: "+rs.getString("title");
						recipient_email = bd.getEmail(recipient_id);
					}
					
				}else{					
					
					if(request.getParameter("id")!=null){
						ResultSet rs = bd.getEvent(request.getParameter("eventId"));
						rs.next();
						
						recipient_id = Integer.parseInt(request.getParameter("id"));
						event_name = rs.getString("name");
						event_id = rs.getInt("id");
						recipient_email = bd.getEmail(recipient_id);
					}else{
						ResultSet rs = bd.getEvent(request.getParameter("eventId"));
						rs.next();
						
						event_name = rs.getString("name");
						event_id = rs.getInt("id");
						recipient_email = "Wszyscy";
					}
					
				}
				
				if(request.getParameter("wyslij")!=null){					
					
					String title = request.getParameter("title");
					String message = request.getParameter("message");
									
					if(bd.sendMessage(recipient_id, Integer.parseInt(session.getAttribute("userId").toString()), event_id, title, message)){
						%>
							<div class="alert alert-success alert-dismissible" role="alert" style="margin-top: 40px;">
								<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								Your message has been sent.
							</div>
						<%
					}else{
						%>
							<div class="alert alert-warning alert-dismissible" role="alert" style="margin-top: 40px;">
								<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								Failed to send the message. Please try again later.
							</div>
						<%
					}				
					
					
				}
				
				bd.disconnect();
				
				%>	
				

				<form data-toggle="validator" role="form" method="post">					
					<div class="form-group">
						<label for="recipient">Odbiorca</label> 
						<input type="text" class="form-control" id="reciepient" name="recipient" value="<%= recipient_email %>" disabled>
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<label for="event">Wydarzenie</label> 
						<input type="text" class="form-control" id="event" name="event" value="<%= event_name %>" disabled>
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<label for="title">Tytuł</label> 
						<input type="text" class="form-control" id="title" name="title" required value="<%= re_title %>">
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<label for="message">Treść wiadomości</label> 
						<textarea class="form-control" id="message" name="message" required rows="7"></textarea>
						<div class="help-block with-errors"></div>
					</div>					
					<input type="submit" class="btn btn-primary pull-right" name="wyslij" value="Wyślij">
				</form>

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>

<%@ include file="../../partials/footer.jsp" %>	