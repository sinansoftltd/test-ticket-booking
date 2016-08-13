<%
/*
Plik autoryzacyjny, który sprawdza czy użytkownik djest zalogowany i czy jest on użytkownikiem typu organizator.
Plik ten ma zabezpieczać podstrony dostępne tylko dla organizatora.
*/

if(session.getAttribute("userId") == null || !session.getAttribute("userType").equals("organizator")){
	response.sendRedirect("../../login.jsp");
}
%>