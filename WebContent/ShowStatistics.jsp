<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Code Wars</title>
</head>
<body>

<%
Object player = request.getAttribute("player");
Object point = request.getAttribute("point");
Object rating = request.getAttribute("rating");

out.print(player + " has " + point + " points and his rating is " + rating + ".");
%>

<button onclick="window.location.href='AdminMain.jsp'">Home Page</button>

</body>
</html>