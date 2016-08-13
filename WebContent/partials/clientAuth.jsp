<%
/*
Plik sprawdajacy czy jest zalogowany uzytkonwnik. Jezeli uzytkownik nie jest zalogowany to zostanie przekierowany na strone logowania.
Plik ma zabezpieczac przed wejściem na podsrony, które wymagają logowania. Plik jest importowany na początku strony, którą ma zabezpieczać.
*/

if(session.getAttribute("userId") == null){
	response.sendRedirect("../../login.jsp");
}
%>