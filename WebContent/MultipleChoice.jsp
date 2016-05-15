<%@ page import="edu.sabanciuniv.testsapp.domain.User" %>
<%@ page import="edu.sabanciuniv.testsapp.domain.Game" %>
<%@ page import="edu.sabanciuniv.testsapp.domain.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Code Wars</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />

  <!-- Latest compiled and minified CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet"/>
  <link href="  https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css" rel="stylesheet"/>

  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>

  <!-- Latest compiled JavaScript -->
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

  <!-- Countdown timer JavaScript -->
          <script type="text/javascript" src="js/TimeCircles.js"></script>
       <!--   <link rel="stylesheet" href="TimeCircles.css" /> -->
     <!--     <link rel="stylesheet" media="only screen and (min-width: 1201px)" href="TimeCircles_1200.css" />
          <link rel="stylesheet" media="only screen and (min-width: 991) and (max-width: 1200)" href="TimeCircles_990.css" />
          <link rel="stylesheet" media="only screen and (max-width: 990)" href="TimeCircles_768.css" /> -->

          <link id="size-stylesheet" rel="stylesheet" type="text/css" href="css/TimeCircles_wide.css" />

          <!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>-->
          <!--<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">--> 

          <style>   /* bottom scroll bar is disabled */
		    html, body {
		        max-width: 100%;
		        overflow: auto;
		        overflow-x: hidden;
		    }
		    
		    body{
		    	padding-top: 100px;
		    	padding-bottom: 60px;
		    }
          </style>
</head>

<body>

	<%
		Game game =(Game)request.getSession().getAttribute("game");	
		int questionIndex = game.getQuestionIndex();
		List<Question> questionList= game.getQuestionList();
		Question currentQuestion = (Question)questionList.get(questionIndex);
		String strQuestion = currentQuestion.getQuestion();
		String optA = currentQuestion.getOptionA();
		String optB = currentQuestion.getOptionB();
		String optC = currentQuestion.getOptionC();
		String optD = currentQuestion.getOptionD();
		String optCorrect = currentQuestion.getAnswer();		
		
		String player1 = "";
		String player2 = "";
		
		User curUser = (User)request.getSession().getAttribute("user");
		if(curUser.getUsername().equals(game.getPlayer1()))
		{
			player1 = game.getPlayer1();
			player2 = game.getPlayer2();	
		}
		else
		{
			player2 = game.getPlayer1();
			player1 = game.getPlayer2();
		}		
	%>

   <div class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a href="../" class="navbar-brand">Bootswatch</a>
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
          <ul class="nav navbar-nav">
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="themes">Themes <span class="caret"></span></a>
              <ul class="dropdown-menu" aria-labelledby="themes">
                <li><a href="../default/">Default</a></li>
                <li class="divider"></li>
                <li><a href="../cerulean/">Cerulean</a></li>
                <li><a href="../cosmo/">Cosmo</a></li>
                <li><a href="../cyborg/">Cyborg</a></li>
                <li><a href="../darkly/">Darkly</a></li>
              </ul>
            </li>
            <li>
              <a href="../help/">Help</a>
            </li>
            <li>
              <a href="http://news.bootswatch.com">Blog</a>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="download" aria-expanded="false">Sandstone <span class="caret"></span></a>
              <ul class="dropdown-menu" aria-labelledby="download">
                <li><a href="http://jsfiddle.net/bootswatch/m0nv7a0o/">Open Sandbox</a></li>
                <li class="divider"></li>
                <li><a href="./bootstrap.min.css">bootstrap.min.css</a></li>
                <li><a href="./bootstrap.css">bootstrap.css</a></li>
                <li class="divider"></li>
                <li><a href="./variables.less">variables.less</a></li>
                <li><a href="./bootswatch.less">bootswatch.less</a></li>
                <li class="divider"></li>
                <li><a href="./_variables.scss">_variables.scss</a></li>
                <li><a href="./_bootswatch.scss">_bootswatch.scss</a></li>
              </ul>
            </li>
          </ul>

          <ul class="nav navbar-nav navbar-right">
            <li><a href="http://builtwithbootstrap.com/" target="_blank">Built With Bootstrap</a></li>
            <li><a href="https://wrapbootstrap.com/?ref=bsw" target="_blank">WrapBootstrap</a></li>
          </ul>

        </div>
      </div>
    </div>

	<div class="container" style="position: relative;">
	
		<!-- <div class="row">
		
			
			<button type="button" id="hiddenButton" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModal" style="visibility:hidden"></button>
			
			
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
	              <div class="modal-body">
		            The game will now start.
		          </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" data-dismiss="modal">Start</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div> -->
	
		<div class="row">
			<div class="col-sm-5">
				<div class="panel panel-primary">
				  <div class="panel-heading">
				    <h3 class="panel-title"><%out.print(player1);%></h3>
				  </div>
				  <div class="panel-body">
				  	Progress
					<div class="progress progress-striped active">
						<div class="progress-bar" style="width: 50%"></div>
					</div>

				  </div>
				</div>
			</div>

		  <div class="col-sm-2">
           <div id="CountDownTimer" data-timer="25" style="width: 200px; height: 200px;"></div> 

            <!--  <div id="CountDownTimer" data-timer="25"></div> -->
      </div>

			<div class="col-sm-5">
				<div class="panel panel-primary">
				  <div class="panel-heading">
				    <h3 class="panel-title"><%out.print(player2);%></h3>
				  </div>
				  <div class="panel-body">
				  	Progress
				  <div class="progress progress-striped active">
						<div class="progress-bar" style="width: 90%"></div>
					</div>
				  </div>
				</div>
			</div>

		</div>
</div>


<div class="container">

		<div class="row"></div>
		<div class="row">
		<div class="col-sm-1"></div>
		<div class="col-sm-10 well" style="white-space: normal;">
			<h4><%out.print(strQuestion);%></h4>
		</div>
		<div class="col-sm-1"></div>
		</div>
		<div class="row">
		<div class="col-sm-2"></div>
		<div class="col-sm-8 ">
			<a href="AnswerServlet?userAnswer=A&correctAnswer=<%out.print(optCorrect);%>" id="optA" class="btn btn-primary btn-lg btn-block" style="white-space: normal;"><% out.print(optA); %></a>
			<a href="AnswerServlet?userAnswer=B&correctAnswer=<%out.print(optCorrect);%>" id="optB" class="btn btn-primary btn-lg btn-block" style="white-space: normal;"><% out.print(optB); %></a>
			<a href="AnswerServlet?userAnswer=C&correctAnswer=<%out.print(optCorrect);%>" id="optC" class="btn btn-primary btn-lg btn-block" style="white-space: normal;"><% out.print(optC); %></a>
			<a href="AnswerServlet?userAnswer=D&correctAnswer=<%out.print(optCorrect);%>" id="optD" class="btn btn-primary btn-lg btn-block" style="white-space: normal;"><% out.print(optD); %></a>
		</div>
		<div class="col-sm-2"></div>
		</div>
	</div>

<!--
  <div class="row"><br/><br/><br/><br/><br/><br/></div>
   <div class="navbar navbar-default navbar-fixed-bottom"> -->


      <script>
		$(document).ready(function(){
			
            $("#CountDownTimer").TimeCircles({
                "animation": "smooth",
                "bg_width": 0.2,
                "fg_width": 0.05,
                "total_duration": 25,
                "count_past_zero": false,
                "circle_bg_color": "#90989F",
                "time": {
                    "Days": {
                        "text": "Days",
                        "color": "#40484F",
                        "show": false
                    },
                    "Hours": {
                        "text": "Hours",
                        "color": "#40484F",
                        "show": false
                    },
                    "Minutes": {
                        "text": "Minutes",
                        "color": "#40484F",
                        "show": false
                    },
                    "Seconds": {
                        "text": "Seconds",
                        "color": "#2C3E50",
                        "show": true
                    }
                }
            }).addListener(function(unit, value, total) {
                  if(total <= 0) {
                    // Do whatever you want to happen when the timer reaches 0 here

                  }
                  else if(total <= 5){
                   // $("#CountDownTimer").TimeCircles({ time: { Days: { show:false }, Hours: { show:false }, Minutes: { show:false }, Seconds: { color: '#900' } } })
                    $("#CountDownTimer").TimeCircles().end().fadeOut(); 
                    $("#CountDownTimer").TimeCircles().end().fadeIn();                    
                 }
             });
		  });
		
		
      </script>     
	</body>




















         <!--     
            $("#CountDownTimer").TimeCircles({ time: { Days: { show: false }, Hours: { show: false }, Minutes: {show: false} }});
            $("#CountDownTimer").TimeCircles({circle_bg_color: "#60686F"});           // default background color of background circle
           // $("#CountDownTimer").TimeCircles({bg_width: 0.1}); 
        $("#CountDownTimer").TimeCircles({fg_width: 0.01});
            $("#CountDownTimer").TimeCircles({count_past_zero: false});               //  stop the timer after it hits zero
            $("#CountDownTimer").TimeCircles({total_duration: 25});                   //  how much time will fill the largest visible circle
            // set the color of foreground circles
            $("#CountDownTimer").TimeCircles({ time: {
                //Days: { color: "#C0C8CF" },
                //Hours: { color: "#C0C8CF" },
                //Minutes: { color: "#C0C8CF" },
                Seconds: { color: "#2C3E50" }
            }}); 
           
         
         //var updateTime = function(){
              //  var date = $("#date").val();
               // var time = $("#time").val();
              //  var datetime = date + ' ' + time + ':00';
               // $("#DateCountdown").data('date', datetime).TimeCircles().start();
           // }
            //  $("#date").change(updateTime).keyup(updateTime);
            //$("#time").change(updateTime).keyup(updateTime);
            
            // Start and stop are methods applied on the public TimeCircles instance
            //$(".startTimer").click(function() {
            //    $("#CountDownTimer").TimeCircles().start();
            //});
            //$(".stopTimer").click(function() {
            //    $("#CountDownTimer").TimeCircles().stop();
           // });


        /*  function adjustStyle(width) {
            width = parseInt(width);
            if (width > 1218) {
              $("#size-stylesheet").attr("href", "TimeCircles_wide.css");
            } else if (width > 1008) {
              $("#size-stylesheet").attr("href", "TimeCircles_medium.css");
            } else if (width > 992) {
              $("#size-stylesheet").attr("href", "TimeCircles_narrow.css");
            } else {
              $("#size-stylesheet").attr("href", "TimeCircles_mobile.css"); 
            }
          }

          $(function() {
            adjustStyle($(this).width());
            $(window).resize(function() {
              adjustStyle($(this).width());
            });
          }); */
          -->
          
</html>