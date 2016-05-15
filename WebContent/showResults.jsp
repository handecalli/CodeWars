<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.sabanciuniv.testsapp.domain.User" %>
<%@ page import="edu.sabanciuniv.testsapp.domain.Game" %>
<%@ page import="edu.sabanciuniv.testsapp.domain.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Code Wars</title>

  <!-- Latest compiled and minified CSS & font-awesome CSS-->
  <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css" rel="stylesheet">
  
    <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

  <!-- Latest compiled JavaScript -->
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  
  <!-- ifvisible.min.js -->
  <script type="text/javascript" src="js/ifvisible.min.js"></script>

<style type="text/css">
@import url(//fonts.googleapis.com/css?family=Open+Sans);

html, body {
    max-width: 100%;
    overflow: auto;
    overflow-x: hidden;
}

body{
  	/*margin: 5px 20px; */
  	background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNiIgaGVpZ2h0PSI2Ij4KPHJlY3Qgd2lkdGg9IjYiIGhlaWdodD0iNiIgZmlsbD0iI2VlZWVlZSI+PC9yZWN0Pgo8ZyBpZD0iYyI+CjxyZWN0IHdpZHRoPSIzIiBoZWlnaHQ9IjMiIGZpbGw9IiNlNmU2ZTYiPjwvcmVjdD4KPHJlY3QgeT0iMSIgd2lkdGg9IjMiIGhlaWdodD0iMiIgZmlsbD0iI2Q4ZDhkOCI+PC9yZWN0Pgo8L2c+Cjx1c2UgeGxpbms6aHJlZj0iI2MiIHg9IjMiIHk9IjMiPjwvdXNlPgo8L3N2Zz4=");
    font-family: 'Open Sans'; 
    font-weight: 300; 
	padding-top: 80px;
	padding-bottom: 60px;
}

h2 {
    margin-bottom: 30px;
    color: #4679bd;
    font-weight: 400;
    text-align: center;
}

p.footer {
    margin-bottom: 20px;
    color: #999999;
    font-size: 18px;
    text-align: center;
}

.alignleft {
	float: left;
}
.alignright {
	float: right;
}

/* -----------------------------------------------
 * Timeline
 * --------------------------------------------- */
 .timeline {
    list-style: none;
    padding: 10px 0;
    position: relative;
    font-weight: 300;
}
.timeline:before {
    top: 0;
    bottom: 0;
    position: absolute;
    content:" ";
    width: 2px;
    background: #ffffff;
    left: 50%;
    margin-left: -1.5px;
}
.timeline > li {
    margin-bottom: 20px;
    position: relative;
    width: 50%;
    float: left;
    clear: left;
}
.timeline > li:before, .timeline > li:after {
    content:" ";
    display: table;
}
.timeline > li:after {
    clear: both;
}
.timeline > li:before, .timeline > li:after {
    content:" ";
    display: table;
}
.timeline > li:after {
    clear: both;
}
.timeline > li > .timeline-panel {
    width: calc(100% - 25px);
    width: -moz-calc(100% - 25px);
    width: -webkit-calc(100% - 25px);
    float: left;
    border: 1px solid #dcdcdc;
    background: #ffffff;
    position: relative;
}
.timeline > li > .timeline-panel:before {
    position: absolute;
    top: 26px;
    right: -15px;
    display: inline-block;
    border-top: 15px solid transparent;
    border-left: 15px solid #dcdcdc;
    border-right: 0 solid #dcdcdc;
    border-bottom: 15px solid transparent;
    content:" ";
}
.timeline > li > .timeline-panel:after {
    position: absolute;
    top: 27px;
    right: -14px;
    display: inline-block;
    border-top: 14px solid transparent;
    border-left: 14px solid #ffffff;
    border-right: 0 solid #ffffff;
    border-bottom: 14px solid transparent;
    content:" ";
}
.timeline > li > .timeline-badge {
    color: #ffffff;
    width: 24px;
    height: 24px;
    line-height: 50px;
    text-align: center;
    position: absolute;
    top: 16px;
    right: -12px;
    z-index: 100;
}
.timeline > li.timeline-inverted > .timeline-panel {
    float: right;
}
.timeline > li.timeline-inverted > .timeline-panel:before {
    border-left-width: 0;
    border-right-width: 15px;
    left: -15px;
    right: auto;
}
.timeline > li.timeline-inverted > .timeline-panel:after {
    border-left-width: 0;
    border-right-width: 14px;
    left: -14px;
    right: auto;
}
.timeline-badge > a {
    color: #ffffff !important;
}
.timeline-badge a:hover {
    color: #dcdcdc !important;
}
.timeline-title {
    margin-top: 0;
    color: inherit;
}
.timeline-heading h4 {
    font-weight: 400;
    padding: 0 15px;
    color: #4679bd;
}
.timeline-body > p, .timeline-body > ul {
    padding: 10px 15px;
    margin-bottom: 0;
}
.timeline-footer {
    padding: 5px 15px;
    background-color:#f4f4f4;
}
.timeline-footer p { margin-bottom: 0; }
.timeline-footer > a {
    cursor: pointer;
    text-decoration: none;
}
.timeline > li.timeline-inverted {
    float: right;
    clear: right;
}
.timeline > li:nth-child(2) {
    margin-top: 60px;
}
.timeline > li.timeline-inverted > .timeline-badge {
    left: -12px;
}
.no-float {
    float: none !important;
}
@media (max-width: 767px) {
    ul.timeline:before {
        left: 40px;
    }
    ul.timeline > li {
        margin-bottom: 0px;
        position: relative;
        width:100%;
        float: left;
        clear: left;
    }
    ul.timeline > li > .timeline-panel {
        width: calc(100% - 65px);
        width: -moz-calc(100% - 65px);
        width: -webkit-calc(100% - 65px);
    }
    ul.timeline > li > .timeline-badge {
        left: 28px;
        margin-left: 0;
        top: 16px;
    }
    ul.timeline > li > .timeline-panel {
        float: right;
    }
    ul.timeline > li > .timeline-panel:before {
        border-left-width: 0;
        border-right-width: 15px;
        left: -15px;
        right: auto;
    }
    ul.timeline > li > .timeline-panel:after {
        border-left-width: 0;
        border-right-width: 14px;
        left: -14px;
        right: auto;
    }
    .timeline > li.timeline-inverted {
        float: left;
        clear: left;
        margin-top: 30px;
        margin-bottom: 30px;
    }
    .timeline > li.timeline-inverted > .timeline-badge {
        left: 28px;
    }
}

</style>
</head>
<body>

	<%
// 		Game game =(Game)request.getSession().getAttribute("game");	
// 		List<Question> questionList = game.getQuestionList();
		
// 		int questionCount = 0;
// 		String player1 = "";
// 		String player2 = "";
// 		List<String> player1Answers = null;
// 		List<String> player2Answers = null;
		
// 		User curUser = (User)request.getSession().getAttribute("user");
// 		if(curUser.getUsername().equals(game.getPlayer1()))
// 		{
// 			player1 = game.getPlayer1();
// 			player1Answers = game.getPlayer1Answers();
			
// 			player2 = game.getPlayer2();	
// 			player2Answers = game.getPlayer2Answers();		
// 		}
// 		else
// 		{
// 			player2 = game.getPlayer1();
// 			player2Answers = game.getPlayer1Answers();
			
// 			player1 = game.getPlayer2();
// 			player1Answers = game.getPlayer2Answers();	
// 		}		
	%>



<h2><i class="fa fa-trophy" aria-hidden="true"></i> You win!</h2>
<h2><i class="fa fa-frown-o" aria-hidden="true"></i> You lost!</h2>

<ul class="timeline">
	
	<%
// 	for(Question currentQuestion : questionList)
// 	{
// 		String strQuestion = currentQuestion.getQuestion();
// 		String optA = currentQuestion.getOptionA();
// 		String optB = currentQuestion.getOptionB();
// 		String optC = currentQuestion.getOptionC();
// 		String optD = currentQuestion.getOptionD();
// 		String optCorrect = currentQuestion.getAnswer();
// 		questionCount++;
		
		
// 		// PLAYER 1 (left side)
// 		out.write("<li>");
// 		out.write("<div class=\"timeline-badge\">");
// 		out.write("<a><i class=\"fa fa-circle\" id=\"\"></i></a>");
// 		out.write("</div>");
// 		out.write(" <div class=\"timeline-panel\">");
// 		out.write("<div class=\"timeline-heading\">");
// 		out.write("Question " + questionCount);
// 		out.write("</div>");
// 		out.write("<div class=\"timeline-body\">");
// 		out.write("Question " + questionCount);					////////////
// 		out.write("</div>");
// 		out.write("<div class=\"timeline-footer\">");
// 		out.write("<p class=\"text-right\">Feb-21-2014</p>");	////////////
// 		out.write("</div>");
// 		out.write("</div>");
// 		out.write("</li>");
				
// 		// PLAYER 2 (right side)
// 		out.write("<li class=\"timeline-inverted\">");
// 		out.write("<div class=\"timeline-badge\">");
// 		out.write("<a><i class=\"fa fa-circle invert\" id=\"\"></i></a>");
// 		out.write("</div>");
// 		out.write(" <div class=\"timeline-panel\">");
// 		out.write("<div class=\"timeline-heading\">");
// 		out.write("Question " + questionCount);
// 		out.write("</div>");
// 		out.write("<div class=\"timeline-body\">");
// 		out.write("Question " + questionCount);					////////////
// 		out.write("</div>");
// 		out.write("<div class=\"timeline-footer\">");
// 		out.write("<p class=\"text-right\">Feb-21-2014</p>");	////////////
// 		out.write("</div>");
// 		out.write("</div>");
// 		out.write("</li>");	
// 	}
	%>








    <li>
        <div class="timeline-badge">
          <a><i class="fa fa-circle" id=""></i></a>
        </div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <h4><i class="fa fa-question-circle" aria-hidden="true"></i> &nbsp;&nbsp; Question 1</h4>
            </div>
            <div class="timeline-body">
            
				 <div class="container">
					<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-7 well well-sm" style="white-space: normal; font-size: 13px" >
						This is the question
					</div>
					<div class="col-sm-1"></div>
					</div>
					<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-5">
						<a href="javascript:;" id="optA" class="btn btn-success btn-xs btn-block" style="white-space: normal;"> option A </a>
						<a href="javascript:;" id="optB" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option B </a>
						<a href="javascript:;" id="optC" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option C</a>
						<a href="javascript:;" id="optD" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option D</a>
					</div>
					<div class="col-sm-2"></div>
					</div>
					<div class="row"><br></div>
				</div>        
            </div>
            <div class="timeline-footer">          	
                <p class="alignleft">Correct Answer!</p>
                <p class="text-right">Feb-21-2014</p>
                <div style="clear: both;"></div>
            </div>         
        </div>
    </li>
    
    <li class="timeline-inverted">
        <div class="timeline-badge">
            <a><i class="fa fa-circle invert" id=""></i></a>
        </div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <h4><i class="fa fa-question-circle" aria-hidden="true"></i> &nbsp;&nbsp; Question 1</h4>
            </div>
            <div class="timeline-body">
            
                <div class="container">
					<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-7 well well-sm" style="white-space: normal; font-size: 13px" >
						This is the question
					</div>
					<div class="col-sm-1"></div>
					</div>
					<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-5">
						<a href="javascript:;" id="optA" class="btn btn-success btn-xs btn-block" style="white-space: normal;"> option A </a>
						<a href="javascript:;" id="optB" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option B </a>
						<a href="javascript:;" id="optC" class="btn btn-danger btn-xs btn-block" style="white-space: normal;"> option C</a>
						<a href="javascript:;" id="optD" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option D</a>
					</div>
					<div class="col-sm-2"></div>
					</div>
					<div class="row"><br></div>
				</div>
				
            </div>
            <div class="timeline-footer">          	
            	<p class="alignleft">Wrong answer!</p>
                <p class="alignright">Feb-23-2014</p>
                <div style="clear: both;"></div>
            </div>
        </div>
    </li>
    
    <li>
        <div class="timeline-badge">
          <a><i class="fa fa-circle" id=""></i></a>
        </div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <h4><i class="fa fa-question-circle" aria-hidden="true"></i> &nbsp;&nbsp; Question 2</h4>
            </div>
            <div class="timeline-body">
            
				 <div class="container">
					<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-7 well well-sm" style="white-space: normal; font-size: 13px" >
						This is the question
					</div>
					<div class="col-sm-1"></div>
					</div>
					<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-5">
						<a href="javascript:;" id="optA" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option A </a>
						<a href="javascript:;" id="optB" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option B </a>
						<a href="javascript:;" id="optC" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option C</a>
						<a href="javascript:;" id="optD" class="btn btn-warning btn-xs btn-block" style="white-space: normal;"> option D</a>
					</div>
					<div class="col-sm-2"></div>
					</div>
					<div class="row"><br></div>
				</div>        
            </div>
            <div class="timeline-footer">          	
                <p class="alignleft">Out of time!</p>
                <p class="text-right">Feb-21-2014</p>
                <div style="clear: both;"></div>
            </div>         
        </div>
    </li>
    
    <li class="timeline-inverted">
                <div class="timeline-badge">
            <a><i class="fa fa-circle invert" id=""></i></a>
        </div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <h4><i class="fa fa-question-circle" aria-hidden="true"></i> &nbsp;&nbsp; Question 2</h4>
            </div>
            <div class="timeline-body">
            
                <div class="container">
					<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-7 well well-sm" style="white-space: normal; font-size: 13px" >
						This is the question
					</div>
					<div class="col-sm-1"></div>
					</div>
					<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-5">
						<a href="javascript:;" id="optA" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option A </a>
						<a href="javascript:;" id="optB" class="btn btn-danger btn-xs btn-block" style="white-space: normal;"> option B </a>
						<a href="javascript:;" id="optC" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option C</a>
						<a href="javascript:;" id="optD" class="btn btn-success btn-xs btn-block" style="white-space: normal;"> option D</a>
					</div>
					<div class="col-sm-2"></div>
					</div>
					<div class="row"><br></div>
				</div>
				
            </div>
            <div class="timeline-footer">          	
            	<p class="alignleft">Wrong answer!</p>
                <p class="alignright">Feb-23-2014</p>
                <div style="clear: both;"></div>
            </div>
        </div>
    </li>   
    
    <li>
        <div class="timeline-badge">
          <a><i class="fa fa-circle" id=""></i></a>
        </div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <h4><i class="fa fa-question-circle" aria-hidden="true"></i> &nbsp;&nbsp; Question 3</h4>
            </div>
            <div class="timeline-body">
            
				 <div class="container">
					<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-7 well well-sm" style="white-space: normal; font-size: 13px" >
						This is the question
					</div>
					<div class="col-sm-1"></div>
					</div>
					<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-5">
						<a href="javascript:;" id="optA" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option A </a>
						<a href="javascript:;" id="optB" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option B </a>
						<a href="javascript:;" id="optC" class="btn btn-success btn-xs btn-block" style="white-space: normal;"> option C</a>
						<a href="javascript:;" id="optD" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option D</a>
					</div>
					<div class="col-sm-2"></div>
					</div>
					<div class="row"><br></div>
				</div>        
            </div>
            <div class="timeline-footer">          	
                <p class="alignleft">Correct Answer!</p>
                <p class="text-right">Feb-21-2014</p>
                <div style="clear: both;"></div>
            </div>         
        </div>
    </li>
    
    <li class="timeline-inverted">
                <div class="timeline-badge">
            <a><i class="fa fa-circle invert" id=""></i></a>
        </div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <h4><i class="fa fa-question-circle" aria-hidden="true"></i> &nbsp;&nbsp; Question 3</h4>
            </div>
            <div class="timeline-body">
            
                <div class="container">
					<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-7 well well-sm" style="white-space: normal; font-size: 13px" >
						This is the question
					</div>
					<div class="col-sm-1"></div>
					</div>
					<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-5">
						<a href="javascript:;" id="optA" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option A </a>
						<a href="javascript:;" id="optB" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option B </a>
						<a href="javascript:;" id="optC" class="btn btn-success btn-xs btn-block" style="white-space: normal;"> option C</a>
						<a href="javascript:;" id="optD" class="btn btn-primary btn-xs btn-block" style="white-space: normal;"> option D</a>
					</div>
					<div class="col-sm-2"></div>
					</div>
					<div class="row"><br></div>
				</div>
				
            </div>
            <div class="timeline-footer">          	
            	<p class="alignleft">Correct answer!</p>
                <p class="alignright">Feb-23-2014</p>
                <div style="clear: both;"></div>
            </div>
        </div>
    </li>   
    
    <li class="clearfix no-float"></li>
</ul>

<!-- <p class="footer">Icons by <a href="http://fortawesome.github.io/Font-Awesome/">FontAwesome 4.1 Icons</a>.<br />
  Created by <a href="http://jenniferperrin.com">Jennifer Perrin</a>
</p> -->


</body>
</html>