<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, java.security.MessageDigest"%>

<%@ include file="partials/header.jsp" %>	
<%@ include file="partials/menu.jsp"%>

	<div class="container">
		<div class="page-header">
		  <h1>Rejestracja</h1>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">

				<%
				/*
				Formularz rejestracji
				*/
				request.setCharacterEncoding("utf-8");
				
				if(request.getParameter("zarejestruj")!=null){
					 
					BazaDanych bd = new BazaDanych();
					bd.polacz();
					
					String email = request.getParameter("email");
					
					if(bd.sprawdzLogin(email)){					
					
						String password = request.getParameter("password");
						
						MessageDigest md = MessageDigest.getInstance("MD5");
				        md.update(password.getBytes());
				        
				        byte byteData[] = md.digest();
				        
				        StringBuffer sb = new StringBuffer();
				        for (int i = 0; i < byteData.length; i++) {
				         	sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				        }
				        
				        String passwordToDb = sb.toString();
						
						if(bd.zarejestruj(email, passwordToDb, request.getParameter("type"))){
							%>
								<div class="alert alert-success" role="alert">Konto zostało zarejestrowane</div>
							<%	
						}else{
							%>
								<div class="alert alert-warning" role="alert">Nie udało się zarejestrować. Spróbuj ponownie później.</div>
							<%						
						}
					
					}else{
						%>
							<div class="alert alert-info" role="alert">Takie konto już jest zarejestrowane.</div>
						<%	
					}
					bd.rozlacz();
					
				}
				
				%>

				<form action="register.jsp" data-toggle="validator" role="form" method="post">
					<div class="form-group">
						<label for="typ">Typ konta</label> 
						<select name="type" class="form-control">
							<option value="organizator" selected>Organizator</option>							
							<option value="klient" selected="selected">Klient</option>
						</select>
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<label for="email">Email</label> 
						<input type="email" class="form-control" id="email" name="email" required>
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<label for="password">Hasło</label> 
						<input type="password" class="form-control" id="password" name="password" required>
						<div class="help-block with-errors"></div>
					</div>
					<div class="form-group">
						<label for="password2">Powtórz hasło</label> 
						<input type="password" class="form-control" id="password2" name="password2" data-match="#password" data-match-error="Musisz poprawnie przepisać hasło" required>
						<div class="help-block with-errors"></div>
					</div>
					<input type="submit" class="btn btn-primary pull-right" name="zarejestruj" value="Zarejestruj">
				</form>

			</div>
			<div class="col-md-4"></div>
		</div>
	</div>

<%@ include file="partials/footer.jsp" %>	