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
		    	padding-top: 140px;
		    	padding-bottom: 60px;
		    }
		    
	    	.navbar-nav {
			  width: 100%;
			  text-align: center;
			}
			.navbar-nav > li {
			  float: none;
			  display: inline-block;
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

	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	  <div class="container-fluid">
	    <div class="navbar-main">
	      <ul class="nav navbar-nav" >
	        <li><a style="font-size: 22px;" href="javascript:;">Code Wars</a></li>
	      </ul>
	    </div>
	  </div>
	</nav>

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
						<div class="progress-bar" style="width: <%out.print(questionIndex*100/7);%>%"></div>
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
						<div class="progress-bar" style="width: <%out.print(questionIndex*100/7);%>%"></div>
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
			<a href="javascript:;" id="optA" class="btn btn-primary btn-lg btn-block" style="white-space: normal;" onclick="submitAnswer('A', '<%out.print(optCorrect);%>', '<%out.print(questionIndex);%>')"><% out.print(optA); %></a>
			<a href="javascript:;" id="optB" class="btn btn-primary btn-lg btn-block" style="white-space: normal;" onclick="submitAnswer('B', '<%out.print(optCorrect);%>', '<%out.print(questionIndex);%>')"><% out.print(optB); %></a>
			<a href="javascript:;" id="optC" class="btn btn-primary btn-lg btn-block" style="white-space: normal;" onclick="submitAnswer('C', '<%out.print(optCorrect);%>', '<%out.print(questionIndex);%>')"><% out.print(optC); %></a>
			<a href="javascript:;" id="optD" class="btn btn-primary btn-lg btn-block" style="white-space: normal;" onclick="submitAnswer('D', '<%out.print(optCorrect);%>', '<%out.print(questionIndex);%>')"><% out.print(optD); %></a>
		</div>
		<div class="col-sm-2"></div>
		</div>
	</div>

<!--
  <div class="row"><br/><br/><br/><br/><br/><br/></div>
   <div class="navbar navbar-default navbar-fixed-bottom"> -->


      <script>
      
      var waitingDialog = waitingDialog || (function ($) {
		    'use strict';

			// Creating modal dialog's DOM
			var $dialog = $(
				'<div class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true" style="padding-top:15%; overflow-y:visible;">' +
				'<div class="modal-dialog modal-m">' +
				'<div class="modal-content">' +
					'<div class="modal-header"> <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> <h3 style="margin:0;"></h3></div>' +
					'<div class="modal-body">' +
						'<div class="progress progress-striped active" style="margin-bottom:0;"><div class="progress-bar" style="width: 100%"></div></div>' +
					'</div>' +
				'</div></div></div>');

			return {
				/**
				 * Opens our dialog
				 * @param message Custom message
				 * @param options Custom options:
				 * 				  options.dialogSize - bootstrap postfix for dialog size, e.g. "sm", "m";
				 * 				  options.progressType - bootstrap postfix for progress bar type, e.g. "success", "warning".
				 */
				show: function (message, options) {
					// Assigning defaults
					if (typeof options === 'undefined') {
						options = {};
					}
					if (typeof message === 'undefined') {
						message = 'Loading';
					}
					var settings = $.extend({
						dialogSize: 'm',
						progressType: '',
						onHide: null // This callback runs after the dialog was hidden
					}, options);

					// Configuring dialog
					$dialog.find('.modal-dialog').attr('class', 'modal-dialog').addClass('modal-' + settings.dialogSize);
					$dialog.find('.progress-bar').attr('class', 'progress-bar');
					if (settings.progressType) {
						$dialog.find('.progress-bar').addClass('progress-bar-' + settings.progressType);
					}
					$dialog.find('h3').text(message);
					// Adding callbacks
					if (typeof settings.onHide === 'function') {
						$dialog.off('hidden.bs.modal').on('hidden.bs.modal', function (e) {
							settings.onHide.call($dialog);
						});
					}
					// Opening dialog
					$dialog.modal();
				},
				/**
				 * Closes dialog
				 */
				hide: function () {
					$dialog.modal('hide');
				}
			};

		})(jQuery);
      
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
                  if(total <= 0) {		// automatically redirect page when time is up
                	//var url = "AnswerServlet?userAnswer=timeout&correctAnswer=timeout&timeLeft=0";          			
                	//document.location.href = url;	
                	submitAnswer("timeout", "<%out.print(optCorrect);%>", <%out.print(questionIndex);%>);
                  }
                  else if(total <= 5){
                   // $("#CountDownTimer").TimeCircles({ time: { Days: { show:false }, Hours: { show:false }, Minutes: { show:false }, Seconds: { color: '#900' } } })
                    $("#CountDownTimer").TimeCircles().end().fadeOut(); 
                    $("#CountDownTimer").TimeCircles().end().fadeIn();                    
                 }
             });
		  });		
		
		 function submitAnswer(playerAnswer, correctAnswer, questionIndex) {
			 		 
		 $("#CountDownTimer").TimeCircles().stop(); 
			var timeLeft = $("#CountDownTimer").TimeCircles().getTime();			
			
			var userOption = "#opt".concat(playerAnswer);
			var correctOption = "#opt".concat(correctAnswer);
			
			if(playerAnswer != correctAnswer && playerAnswer != "timeout")				
				$(userOption).removeClass("btn-primary").addClass("btn-danger");
			if(playerAnswer != "timeout")
				$(correctOption).removeClass("btn-primary").addClass("btn-success");
			else
			{
				$(correctOption).removeClass("btn-primary").addClass("btn-warning");
				timeLeft = 0;
			}
			
			//	$dialog.find('.modal-dialog').attr('arialabelledby', 'modal-dialog').addClass('modal-' + settings.dialogSize);
		 

			//var base = "AnswerServlet?userAnswer=";
			//var url = base.concat(playerAnswer, "&correctAnswer=", correctAnswer, "&timeLeft=", timeLeft);
					
			//document.location.href = url;
			
			$.ajax({   		   
	   		    // The URL for the request
	   		    url: "AnswerServlet",
	   		 
	   		    // The data to send (will be converted to a query string)
	   		    data: {
	   		    	   userAnswer : playerAnswer,
	    			   correctAnswer : correctAnswer,
	    			   timeLeft : timeLeft
	        	   },
	   		 
	   		    // Whether this is a POST or GET request
	   		    type: "GET",
	   		 
	   		    // The type of data we expect back
	   		    //dataType : "application/json",
	   		    
	   		    //the type of the request body. 
	   		    contentType: "application/json",
	   		    
	   		    // Whether to use a cached response if available
	   		    cache : false     		   
	   		}).done(function(response) {   			
				if(questionIndex == 6)
				{
		   			console.log("waiting for opponent..");
					waitingDialog.show('Waiting for your opponent to finish...');
					waitOpponent();
				}
				else if(questionIndex < 6)
					document.location.href = "MultipleChoice.jsp";
	   		})
		 }
			
		function waitOpponent() {
					
			 $.ajax({   		   
		   		    // The URL for the request
		   		    url: "ShowResultServlet",
		   		 
		   		    // The data to send (will be converted to a query string)
		   		    data: {
							type: "multiple"
		        	   },
		   		 
		   		    // Whether this is a POST or GET request
		   		    type: "GET",
		   		 
		   		    // The type of data we expect back
		   		    //dataType : "application/json",
		   		    
		   		    //the type of the request body. 
		   		    contentType: "application/json",
		   		    
		   		    // Whether to use a cached response if available
		   		    cache : false     		   
		   		})
		   		  // Code to run if the request succeeds (is done);
		   		  // The response is passed to the function
		   		.done(function(response) {
		   			console.log("state: " + response.state);
		   			if(response.state != 3) // waiting
		   			{
		   				//loading results modal pıliiiz
		   				setTimeout(function(){		// CHECK IF THE OPPONENT FINISHED ANSWERING, EVERY 3 SECONDS
		   					waitOpponent();
		   			    }, 3000);
		   			}
		   			else 
		   				window.location.href = "/TestWeb/showResults.jsp";
		   		})
		   		.fail(function( xhr, status, errorThrown ) {

						console.log( "Error: " + errorThrown );
						console.log( "Status: " + status );
						console.dir( xhr );
		   		})
		}
			
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