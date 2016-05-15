<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Code Wars</title>

<style type="text/css">
/* Dropdown Button */
.dropbtn {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

/* Dropdown button on hover & focus */
.dropbtn:hover, .dropbtn:focus {
    background-color: #3e8e41;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
    position: relative;
    display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

/* Links inside the dropdown */
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {background-color: #f1f1f1}

/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
.show {display:block;}

</style>

<script type="text/javascript" >
/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function SlideOptions() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

</script>
</head>
<body>
<span style="color: blue;">

<% 

Object username = request.getAttribute("username");
Object points = request.getAttribute("points");
Object rating = request.getAttribute("rating");

if(username!=null && points!=null && rating !=null)
{
	out.print("Hello " + username + " welcome to code wars!");
	out.print(" Points:" + points + " Rating: " + rating);
}
else
{
	System.out.println("bisiler yanlis gidiyo. username points ya da rating null");
}
%>

</span><br/>

<div class="dropdown">
  <button onclick="SlideOptions()" class="dropbtn">PLAY</button>
  <div id="myDropdown" class="dropdown-content">
    <a href="MultipleChoice.jsp">Multiple Choice </a>
    <a href="CodeWriting.jsp">Write your code</a>
    <a href="CodeCorrection.jsp">Code correction</a>
  </div>
</div><br/>

<form action="FriendServlet" method="post">
Search Friend:
<input type="text" name="friendName"><br/>
<input type="submit" value="Add Friends"><br/>
<input type="hidden" name="userName" value="<%=username%>" />
<var>  </var>
</form>

<form action="EditProfileServlet" method="post">
<input type="submit" value="Edit Profile"><br/>
</form>

<form action="LeaderboardServlet" method="post">
<input type="submit" value="LeaderBoards"><br/>
</form>

<form action="StatisticsServlet" method="post">
Request student statistics:
<input type="text" name="player">
<input type="submit" value="Search User"><br/>
<var>  </var>
</form>


<hr/>
<%
out.print("insert footer");
out.print(new Date());
%>
</body>
</html>