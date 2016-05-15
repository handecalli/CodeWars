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
  
  <link href="shCore.css" rel="stylesheet" type="text/css" />
  <link href="shThemeDefault.css" rel="stylesheet" type="text/css" />
</head>
<body>

	<form action="QuestionServlet" method="get">
	<textarea name="user_code" placeholder="Write your code here..." rows="25" cols="120" ></textarea><br>
	<input type="submit" value="Send"> 
	<input type="hidden" name="dothis" value="Add" />
	</form>

  <pre class='brush: cpp'>
  
  // my first program in C++
  #include <iostream>
  using namespace std;

  int main ()
  {
    cout << "Hello World!";
    return 0;
  }
  
  
  </pre>


  <script src="shCore.js"></script>
  <script src="shBrushCpp.js"></script>
  <script>
    SyntaxHighlighter.all()
  </script>
</body>
</html>