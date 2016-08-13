<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" import="pakiet.*, java.sql.ResultSet"%>
	
	
	
<!-- fragment strony odpowiadajacy za wyswietlanie menu -->	
	
	
	
	
<nav class="navbar navbar-default">
  <div class="container">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="index.jsp">Rezerwacje biletów</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">      
      <ul class="nav navbar-nav navbar-right">
      	<%
      	if(session.getAttribute("userId") == null){
      	%>
        <li><a href="register.jsp">Rejestracja</a></li>
        <li><a href="login.jsp">Logowanie</a></li>
        <%
      	}else{
      		
      		BazaDanych bd = new BazaDanych();
      		bd.polacz();
      		
      		int count = bd.policzNoweWiadomosci(Integer.parseInt(session.getAttribute("userId").toString()));
      		
      		bd.rozlacz();
      		
      		if(session.getAttribute("userType").toString().equals("klient")){
        %>
        		<li><a href="user/client/messages.jsp">Wiadomości <span class="badge"><%= count %></span></a></li>
        		<li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= session.getAttribute("userLogin") %> <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="user/client/reservations.jsp">Moje rezerwacje</a></li>
		            <li role="separator" class="divider"></li>
		            <li><a href="login.jsp">Wyloguj</a></li>
		          </ul>
		        </li>
        <%
      		}else{
      	%>
      			<li><a href="user/client/messages.jsp">Wiadomości <span class="badge"><%= count %></span></a></li>
      			<li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= session.getAttribute("userLogin") %> <span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="user/organizer/events.jsp">Moje wydarzenia</a></li>
		            <li><a href="user/client/reservations.jsp">Moje rezerwacje</a></li>
		            <li role="separator" class="divider"></li>
		            <li><a href="login.jsp">Wyloguj</a></li>
		          </ul>
		        </li>
      			
      	<%
      		}
      	}
        %>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>