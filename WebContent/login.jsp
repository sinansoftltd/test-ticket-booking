<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, java.security.MessageDigest, sinan.database.ResultSet"%>

<%@ include file="partials/header.jsp" %>

<%
session.removeAttribute("userLogin");
session.removeAttribute("userType");
session.removeAttribute("userId");
%>
	
<%@ include file="partials/menu.jsp"%>

	<div class="container">
		<div class="page-header">
		  <h1>Logowanie</h1>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">

				<%
				/*
				Formularz logowania
				*/
				request.setCharacterEncoding("utf-8");
				
				if(request.getParameter("login")!=null){
					 
					Booking bd = new Booking();
					bd.connect();
					
					String email = request.getParameter("email");
					String password = request.getParameter("password");
					
					MessageDigest md = MessageDigest.getInstance("MD5");
			        md.update(password.getBytes());
			        
			        byte byteData[] = md.digest();
			        
			        StringBuffer sb = new StringBuffer();
			        for (int i = 0; i < byteData.length; i++) {
			         	sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			        }
			        
			        String passwordToDb = sb.toString();
			        
			        ResultSet rs = bd.log(email, passwordToDb);
			        
			        if(rs != null && rs.next()){
			        	session.setAttribute( "userLogin", rs.getString("email"));
			        	session.setAttribute( "userType", rs.getString("type"));
			        	session.setAttribute( "userId", rs.getString("id"));
			        	
			        	response.sendRedirect("index.jsp");
			        }else{
			        	%>
							<div class="alert alert-danger" role="alert">Incorrect login or password!</div>
						<%	
			        }
					
					
					bd.disconnect();
					
				}
				
				%>

				<form action="login.jsp" data-toggle="validator" role="form" method="post">					
					<div class="form-group">
						<label for="email">Email</label> 
						<input type="email" class="form-control" id="email" name="email" value="<%if(request.getParameter("email") != null) %><%= request.getParameter("email") %>">
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<label for="password">Password</label>
						<input type="password" class="form-control" id="password" name="password">
					</div>					
					<input type="submit" class="btn btn-primary pull-right" name="login" value="Zaloguj">
				</form>

			</div>
			<div class="col-md-4"></div>
		</div>
	</div>

<%@ include file="partials/footer.jsp" %>	