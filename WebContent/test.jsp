<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.IOException" %>
<%@page import= "java.io.InputStreamReader" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Code Wars</title>
</head>
<body>

<form action="CompilerServlet" method="get">
<textarea name="user_code" placeholder="Write your code here..." rows="30" cols="120" ></textarea><br>
<input type="submit" value="Send"> 
</form>

</body>
</html>