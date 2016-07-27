<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.List" %>
<%@page import="java.util.Date"%>
<%@ page import="edu.sabanciuniv.testsapp.domain.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Code Wars</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />

  <!-- Latest compiled and minified CSS & font-awesome CSS-->
  <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/flatly/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>

  <!-- Latest compiled JavaScript -->
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  
  <!-- ifvisible.min.js -->
  <script type="text/javascript" src="js/ifvisible.min.js"></script>

  <style>   /* bottom scroll bar is disabled */
    html, body {
        max-width: 100%;
        overflow: auto;
        overflow-x: hidden;
    }
    
    body{
    	padding-top: 80px;
    	padding-bottom: 60px;
    	
    	height: 100vh;
    }
    
    /*** TOOLTIP ***/
    /* alert text properties */
    #alertTip.alert-info {
        color: #2C3E50;
        background-color: #ECF0F1;
        border-color: #ECF0F1;
    }
    /* alert width 
    #alertTip.alert {
       width:100%;   
    } */
    /* color of alert close button */
    #alertTip.alert .close {
       color: #2C3E50;  
    }
    /* properties of horizontal line */
    #alertHR {
        display: block;
        height: 1px;
        width: 95%;
        border: 0;
       /* border-top: 1px solid #ccc; */
        margin: 0.3em 0;
        padding: 0; 
        border-color: #2C3E50;
        color: #2C3E50;
        background-color: #2C3E50;
    }
    /***************/

    /*** FRIEND REQUEST SPANS ***/
    /* width of span elements */
    #check{
      width: 2em;
    }
    #times{
      width: 2em;
    }
    /* hover colors for span elements */
    #check:hover {
      background-color: #18B07D; 
    }
    #times:hover {
      background-color: #E74C3C;
    }
    
    #request a{
      pointer-events: none; /* for not clickable portions */
      cursor: default;      /* for not clickable portions */
      float: right;
      padding-left: 7px;    /* space between friend add-reject buttons */
    }

    #request span{
      cursor: pointer;      /* clickable for visible portion */
      pointer-events: auto; /* clickable for visible portion */
    }

    #searchButton{
      background-color: #ECF0F1;
      color: #2C3E50;
      border-color: #2C3E50;
    }

    #searchInput{
      border-color: #2C3E50;
    }
    
    #available{
    	color: #18B07D;
    }
    
    #notavailable{
    	color: #E74C3C;
    }
    

    /****************************/
    
    
    #_OnlineList .wrap {
  box-shadow: 0px 2px 2px 0px rgba(0, 0, 0, 0.14), 0px 3px 1px -2px rgba(0, 0, 0, 0.2), 0px 1px 5px 0px rgba(0, 0, 0, 0.12);
  border-radius: 4px;
}

#_OnlineList a:focus,
#_OnlineList a:hover,
#_OnlineList a:active {
  outline: 0;
  text-decoration: none;
}

#_OnlineList .panel {
  border-width: 0 0 1px 0;
  border-style: solid;
  border-color: #fff;
  background: none;
  box-shadow: none;
}

#_OnlineList .panel:last-child {
  border-bottom: none;
}

#_OnlineList .panel-group > .panel:first-child .panel-heading {
  border-radius: 4px 4px 0 0;
}

#_OnlineList .panel-group .panel {
  border-radius: 0;
}

#_OnlineList .panel-group .panel + .panel {
  margin-top: 0;
}

#_OnlineList .panel-heading {
  background-color: #2C3E50;
  border-radius: 0;
  border: none;
  color: #fff;
  padding: 0;
}

#_OnlineList .panel-title a {
  display: block;
  color: #fff;
  padding: 15px;
  position: relative;
  font-size: 16px;
  font-weight: 400;
}

#_OnlineList .panel-body {
  background: #fff;
}

#_OnlineList .panel:last-child .panel-body {
  border-radius: 0 0 4px 4px;
}

#_OnlineList .panel:last-child .panel-heading {
  border-radius: 0 0 4px 4px;
  transition: border-radius 0.3s linear 0.2s;
}

#_OnlineList .panel:last-child .panel-heading.active {
  border-radius: 0;
  transition: border-radius linear 0s;
}
/* #bs-collapse icon scale option */

#_OnlineList .panel-heading a:before {
  content: '\e146';
  position: absolute;
  font-family: 'Material Icons';
  right: 5px;
  top: 10px;
  font-size: 24px;
  transition: all 0.5s;
  transform: scale(1);
}

#_OnlineList .panel-heading.active a:before {
  content: ' ';
  transition: all 0.5s;
  transform: scale(0);
}

#_OnlineList #bs-collapse .panel-heading a:after {
  content: ' ';
  font-size: 24px;
  position: absolute;
  font-family: 'Material Icons';
  right: 5px;
  top: 10px;
  transform: scale(0);
  transition: all 0.5s;
}

#_OnlineList #bs-collapse .panel-heading.active a:after {
  content: '\e909';
  transform: scale(1);
  transition: all 0.5s;
}
/* #accordion rotate icon option */

#_OnlineList #accordion .panel-heading a:before {
  content: '\e316';
  font-size: 24px;
  position: absolute;
  font-family: 'Material Icons';
  right: 5px;
  top: 10px;
  transform: rotate(180deg);
  transition: all 0.5s;
}

#_OnlineList #accordion .panel-heading.active a:before {
  transform: rotate(0deg);
  transition: all 0.5s;
}
    
		
    /*.progress{
      height: 11px;
    }*/

   /* .col-sm-2{
      height: 135px;
    }*/

	/* TEST 
    * {
   		outline: 1px solid red;
  	}	*/
	
	.avatar {
    /*float: left;
    margin-top: 1em;
    margin-right: 1em;*/
    margin-top: 15px;
    margin-left: 5px;
    position: relative;

    -webkit-border-radius: 50%;
    -moz-border-radius: 50%;
    border-radius: 50%;

    -webkit-box-shadow: 0 0 0 3px #fff, 0 0 0 4px #999, 0 2px 5px 4px rgba(0,0,0,.2);
    -moz-box-shadow: 0 0 0 3px #fff, 0 0 0 4px #999, 0 2px 5px 4px rgba(0,0,0,.2);
    box-shadow: 0 0 0 3px #fff, 0 0 0 4px #999, 0 2px 5px 4px rgba(0,0,0,.2);
}

#pad{
	padding-left: 33px;
}


/* AVATAR */

#avatar {
    position: relative;
    border-radius: 5px 5px 5px 5px;
    /*content: url(img/1.jpg);*/
    margin-top: 8px;
    margin-left: 10px;
    height: 220px;
    width: 220px;
    /*padding: 20px;   */

    -webkit-box-shadow: 0 0 0 2px #fff, 0 0 0 0px transparent, 0 2px 5px 4px rgba(0,0,0,.2);
    -moz-box-shadow: 0 0 0 2px #fff, 0 0 0 0px transparent, 0 2px 5px 4px rgba(0,0,0,.2);
    box-shadow: 0 0 0 2px #fff, 0 0 0 0px transparent, 0 2px 5px 4px rgba(0,0,0,.2);
}



/* GRAPH */
.legend {
  margin-top: 200px;
}

.widget {
  margin: 0 auto;
  width: 350px;
  background-color: #222D3A;
  border-radius: 5px;
  box-shadow: 0px 0px 1px 0px #06060d;
}
#header {
  background-color: #29384D;
  height: 40px;
  color: #FFFFFF;
  text-align: center;
  line-height: 40px;
  border-top-left-radius: 7px;
  border-top-right-radius: 7px;
  font-weight: 400;
  font-size: 1.5em;
  text-shadow: 1px 1px #06060d;
}

.chart-container {
  padding: 25px;
}

.shadow {
  -webkit-filter: drop-shadow( 0px 3px 3px rgba(0, 0, 0, .5));
  filter: drop-shadow( 0px 3px 3px rgba(0, 0, 0, .5));
}

	
	
  </style>
</head>

<body>

<%
	User user = (User)request.getSession().getAttribute("user");
	String username = "";
	String userImage = "";
	List<String> friendReq = null;
	List<String> friendList = null;
	int points = 0;
	int rating = 0;
	if(user != null)
	{
	    username = user.getUsername();
	    points = user.getPoints();
		rating = user.getRating();
		friendList = user.getFriendList();
		friendReq = user.getFriendReq();
	//	out.print("Hello " + username + " welcome to code wars!");
	//	out.print(" Points:" + points + " Rating: " + rating);	
		
		int ID = user.getImageID();	
		String imageID = String.valueOf(ID);
		userImage =  "content: url(img/" + imageID + ".jpg;";
		
		//response.setContentType("image/gif");
		//OutputStream o = response.getOutputStream();
		//o.write(imgData);
		//o.flush();
		//o.close();
	}
	else
	{
		System.out.println("bisiler yanlis gidiyo. user null dondu");
	}
	//Object addFriendStatusCheck = request.getAttribute("check");
%>

   <div class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a href="../" class="navbar-brand">Code Wars</a>
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
          <ul class="nav navbar-nav">
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;" id="themes">Random Challenge<span class="caret"></span></a>
              <ul class="dropdown-menu" aria-labelledby="themes">
                <li><a href="javascript:;" id="randomMultiple" onclick="waitingDialog.show('Waiting for another player...');">Multiple Choice</a></li>
                <li><a href="GameServlet?type=coding" id="randomCoding" onclick="waitingDialog.show('Waiting for another player...');">Coding</a></li>
              </ul>
            </li>

            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:;" id="themes">Training<span class="caret"></span></a>
              <ul class="dropdown-menu" aria-labelledby="themes">
                <li><a href="../default/">All categories</a></li>
                <li class="divider"></li>
                <li><a href="javascript:;">Classes</a></li>
                <li><a href="javascript:;">Output</a></li>
                <li><a href="javascript:;">Pointers</a></li>
                <li><a href="javascript:;">Matrix</a></li>
              </ul>
            </li>

            <li>
              <a href="../help/">Leaderboard</a>
            </li>
          </ul>

          <ul class="nav navbar-nav navbar-right">
            <li>

              <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                  <input type="text" id="searchInput" class="form-control" placeholder="Search friends">
                </div>
                <button type="submit" id="searchButton" class="btn ripple-effect btn-default" style="outline:none;"><strong>Search</strong></button>
              </form>
            </li>

            <li><a href="https://wrapbootstrap.com/?ref=bsw" target="_blank" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Edit profile"><i class="fa fa-cog" aria-hidden="true" style="font-size: 25px;"></i></a>
            </li>

            <li><a href="/TestWeb/index.html" id="logoutButton" target="_blank" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Sign out"><i class="fa fa-sign-out" aria-hidden="true" style="font-size: 25px;"></i></a>
            </li>
          </ul>

        </div>
      </div>
    </div>


   <div class="container" style="position: relative;">

      <div class="col-sm-9">
      
          <div class="panel panel-primary">
            <div class="panel-heading">
              <h3 class="panel-title"> <%out.print( "Welcome " + username + "!"); %> </h3>
            </div>
	        <div class="panel-body"> 
	       <div class="row">  
			<div class="col-sm-4">
			  <div id="avatar" style="<%out.print(userImage);%>"></div>
	        </div>
	        <div class="col-sm-2"></div>
	        <div class="col-sm-6">
			
    		  
	        </div>      	        
           </div>	  <!--  row -->
          
		<div class="row" style="margin-top:25px;">
          <div class="col-sm-5" id="_OnlineList">
          <div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
      <div class="panel">
        <div class="panel-heading" role="tab" id="headingOne">
          <h4 class="panel-title">
        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          <i class="fa fa-frown-o" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hande vs tugcan
        </a>
      </h4>
        </div>
        <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
          <div class="panel-body">
            Result: LOST <br>
            hande: 132 points <br>
            tugcan: 133 points <br>
          </div>
        </div>
      </div>
      <!-- end of panel -->

      <div class="panel">
        <div class="panel-heading" role="tab" id="headingTwo">
          <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          <i class="fa fa-trophy" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hande vs melda
        </a>
      </h4>
        </div>
        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
          <div class="panel-body">
            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch.
          </div>
        </div>
      </div>
      <!-- end of panel -->

      <div class="panel">
        <div class="panel-heading" role="tab" id="headingThree">
          <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          <i class="fa fa-trophy" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hande vs tugcan
        </a>
      </h4>
        </div>
        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
          <div class="panel-body">
            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch.
          </div>
        </div>
      </div>
      <!-- end of panel -->

      <div class="panel">
        <div class="panel-heading" role="tab" id="headingFour">
          <h4 class="panel-title">
        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
          <i class="fa fa-frown-o" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hande vs doruk
        </a>
      </h4>
        </div>
        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
          <div class="panel-body">
            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch.
          </div>
        </div>
      </div>
      <!-- end of panel -->

    </div>
    <!-- end of #accordion -->
          
      </div> <!-- column 5 -->    
      <div class="col-sm-1"></div>
      <div class="col-sm-5">
      
			  <!--  GRAPH  -->

				<div class="widget">
				    <div id="header">Statistics</div>
				    <div id="chart" class="chart-container"></div>
				</div>
    		  
      </div>
      
        
      </div> <!--  row -->
      </div>  <!--  panel body -->
      </div>    <!--  panel -->                
 
        
        
        
   <div class="row">   
  
   </div>
        
        <div class="row"> <!--  LEADERBOARD  -->
        
       <div class="panel panel-primary">
		  <div class="panel-heading">
		    <h3 class="panel-title">Leaderboard</h3>
		  </div>
		  <div class="panel-body">
		    




		  </div>
		</div>
        
       
        </div>
        
        
      </div> <!--  column -->


        <!-- right panel -->
        <div class="col-sm-3" id="pad">
     
          <div class="row" id="alertTipRow">     
              <div id="alertTip" class="alert alert-dismissible alert-info">
              	<!--  <button id="challengeTipClose" type="button" class="close" data-dismiss="alert" >&times;</button> -->
                <button id="challengeTipClose" type="button" style="outline:none;" class="close">&times;</button>
                <strong>Quick Tip!</strong> <br> Click on your online friends to send them a challenge. <hr id="alertHR"> Click on your friend requests to accept or reject.
              </div>  
          </div>

          <!-- online friends -->
          <div class="row" id="_OnlineFriends">
            <div class="list-group">
              <div class="list-group-item active">  Online Friends <span class="badge"> <i class="fa fa-user" aria-hidden="true"></i> 2 </span> </div>
              <a href="javascript:;" class="list-group-item" data-toggle="tooltip2" data-placement="right" title="" data-original-title="Click to challenge!"><i id="available" class="fa fa-dot-circle-o" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;melda</a>
              <a href="javascript:;" class="list-group-item" data-toggle="tooltip2" data-placement="right" title="" data-original-title="Currently in game!"><i id="notavailable" class="fa fa-dot-circle-o" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tugcan</a>
	        </div>
          </div>
         
          
          <%
          if(friendList != null && friendList.size() >  0)
          {
        	  out.write("<div class=\"row\" id=\"_OnlineFriends\">");
        	  out.write("<div class=\"list-group\">");
              out.write("<div class=\"list-group-item active\">  Online Friends <span class=\"badge\"> <i class=\"fa fa-user\" aria-hidden=\"true\"></i> 2 </span> </div>");

              
              for(String friend : friendList)
              {
            	  // available
            	  out.write("<a href=\"javascript:;\" class=\"list-group-item\" data-toggle=\"tooltip2\" data-placement=\"right\" title=\""+ friend + "\" data-original-title=\"Click to challenge!\"><i id=\"available\" class=\"fa fa-dot-circle-o\" aria-hidden=\"true\"></i>" + friend + "</a>");
              	  // not available
              	  out.write("<a href=\"javascript:;\" class=\"list-group-item\" data-toggle=\"tooltip2\" data-placement=\"right\" title=\""+ friend + "\" data-original-title=\"Currently in game!\"><i id=\"notavailable\" class=\"fa fa-dot-circle-o\" aria-hidden=\"true\"></i>" + friend + "</a>");
              }
              
              out.write("</div>");
              out.write("</div>");
          }              
          %>        
          
          <%
          // GENERATE FRIEND REQUEST LIST
          if(friendReq != null && friendReq.size() >  0)
          {
        	  out.write("<div class=\"row\" id=\"_FriendRequests\">");
        	  out.write("<div class=\"list-group\">");
              out.write("<div>");
              out.write("<div class=\"list-group-item active\">");
              out.write("Friend Requests");
              out.write("<span class=\"badge\" id=\"_RequestCount\"> <i class=\"fa fa-user-plus\" aria-hidden=\"true\"></i> " + friendReq.size() + "</span>");
              out.write("</div>");
              out.write("</div>");
              
              for(String req : friendReq)
              {
            	  out.write("<div>");
            	  out.write("<div id=\"request\" class=\"list-group-item\" aria-labelledby=\"" + req + "\">" + req);
            	  out.write("<a href=\"javascript:;\" class=\"reject\"> <span id=\"times\" class=\"badge\"> <i class=\"fa fa-times\" aria-hidden=\"true\"></i> </span> </a>"); 
            	  out.write("<a href=\"javascript:;\" class=\"accept\"> <span id=\"check\" class=\"badge\"> <i class=\"fa fa-check\" aria-hidden=\"true\"></i> </span> </a>");
                  out.write("</div>");
                  out.write("</div>");
              }
              
              out.write("</div>");
              out.write("</div>");
          }
        %>
          
          
          <!-- alerts -->
          <div class="row" id="_FriendAlerts">
              <div class="alert alert-success" role="alert" id="responseAlert" style="display:none;">
      			<strong><i class="fa fa-info-circle" aria-hidden="true"></i></strong> message
    		  </div>
          </div>
    
        </div> 
    </div>
    


<!-- -->

   <div class="navbar navbar-default navbar-fixed-bottom"></div> 


        <script>		
  
        /***************** ALL JQUERY CODE GOES IN HERE *****************/  
        /* $(document).ready(function(){}) prevents any jQuery code 
        from running before the document is fully loaded (is ready). */
        
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
        	// GRAPH 2
        	
        	var dataset = [
               { name: 'WIN', percent: 39.10 },
               { name: 'LOSE', percent: 32.51 },
               { name: 'QUIT', percent: 13.68 },
           ];

           var pie=d3.layout.pie()
                   .value(function(d){return d.percent})
                   .sort(null)
                   .padAngle(.03);

           var w=300,h=300;

           var outerRadius=w/2;
           var innerRadius=100;

          //var color = d3.scale.category10();
          
           var color = d3.scale.ordinal()
			.range(["#18B07D", "#E74C3C" , "#F39C12"]);

           var arc=d3.svg.arc()
                   .outerRadius(outerRadius)
                   .innerRadius(innerRadius);

           var svg=d3.select("#chart")
                   .append("svg")
                   .attr({
                       width:w,
                       height:h,
                       class:'shadow'
                   }).append('g')
                   .attr({
                       transform:'translate('+w/2+','+h/2+')'
                   });
           var path=svg.selectAll('path')
                   .data(pie(dataset))
                   .enter()
                   .append('path')
                   .attr({
                       d:arc,
                       fill:function(d,i){
                           return color(d.data.name);
                       }
                   });

           path.transition()
                   .duration(1000)
                   .attrTween('d', function(d) {
                       var interpolate = d3.interpolate({startAngle: 0, endAngle: 0}, d);
                       return function(t) {
                           return arc(interpolate(t));
                       };
                   });


           var restOfTheData=function(){
               var text=svg.selectAll('text')
                       .data(pie(dataset))
                       .enter()
                       .append("text")
                       .transition()
                       .duration(200)
                       .attr("transform", function (d) {
                           return "translate(" + arc.centroid(d) + ")";
                       })
                       .attr("dy", ".4em")
                       .attr("text-anchor", "middle")
                       .text(function(d){
                           return d.data.percent+"%";
                       })
                       .style({
                           fill:'#fff',
                           'font-size':'10px'
                       });

               var legendRectSize=20;
               var legendSpacing=12;
               var legendHeight=legendRectSize+legendSpacing;

               var legend=svg.selectAll('.legend')
                       .data(color.domain())
                       .enter()
                       .append('g')
                       .attr({
                           class:'legend',
                           transform:function(d,i){
                               //Just a calculation for x & y position
                               return 'translate(-35,' + ((i*legendHeight)-45) + ')';
                           }
                       });
               legend.append('rect')
                       .attr({
                           width:legendRectSize,
                           height:legendRectSize,
                           rx:20,
                           ry:20
                       })
                       .style({
                           fill:color,
                           stroke:color
                       });

               legend.append('text')
                       .attr({
                           x:30,
                           y:15
                       })
                       .text(function(d){
                           return d;
                       }).style({
                           fill:'#929DAF',
                           'font-size':'14px'
                       });
           };

           setTimeout(restOfTheData,1000);	
        	
           var timeoutHandle;   // handle timeouts (reset)    
           
           /* show tooltips */
           $('[data-toggle="tooltip"]').tooltip({container: 'body'});   
           $('[data-toggle="tooltip2"]').tooltip({container: '.col-sm-3'}); 
          
           /* fade out tooltip*/
           $("#challengeTipClose").click(function(){
              $("#alertTipRow").animate({
                  height: 'toggle'
           	  });
           });
           
           $('.collapse.in').prev('.panel-heading').addClass('active');
           $('#accordion, #bs-collapse')
           .on('show.bs.collapse', function(a) {
             $(a.target).prev('.panel-heading').addClass('active');
           })
           .on('hide.bs.collapse', function(a) {
             $(a.target).prev('.panel-heading').removeClass('active');
           });
            
           /* REJECT FRIEND REQUEST */
           $(".reject").click(function(){
        	  var friendName = $(this).parent().text();
        	  var requestCount = $("#_RequestCount").text() - 1; // new request count
        	  
        	  /**** SHOW AN ALERT, CLOSE IT AFTER 2 SECONDS ****/
        	  $("#responseAlert").removeClass("alert-success alert-danger").addClass("alert-danger");
        	  $("#responseAlert").text("You rejected a friend request from " + friendName + ".");
        	  $("#_FriendAlerts").show();
        	  $("#responseAlert").fadeIn();
        	 
        	  // reset timer in case it already started
        	  window.clearTimeout(timeoutHandle);
        	  // close alert after 2 seconds (2000ms)
        	  timeoutHandle = window.setTimeout(function() {
        		  $("#_FriendAlerts").animate({
                      height: 'hide'
               	  });
        	  }, 2000);
        	  /**** SHOW AN ALERT, CLOSE IT AFTER 2 SECONDS ****/
   			  
        	  if(requestCount == 0) // if no more requests left; close whole panel
        	  {
        		  $(this).parentsUntil("#_FriendRequests").animate({
                      height: 'hide'
               	  });
        	  }
        	  else                  // decrease number of requests by 1
        	  {
        		  $("#_RequestCount").html('<i class="fa fa-user-plus" aria-hidden="true"></i> ' + requestCount);
            	  $(this).parentsUntil(".list-group").animate({
                      height: 'hide'
               	  });
        	  }
           });
           
           /* ACCEPT FRIEND REQUEST */
           $(".accept").click(function(){    	   
         	  var friendName = $(this).parent().text();
        	  var requestCount = $("#_RequestCount").text() - 1; // new request count 
        	        	  
        	  /**** SHOW AN ALERT, CLOSE IT AFTER 2 SECONDS ****/
        	  $("#responseAlert").removeClass("alert-success alert-danger").addClass("alert-success");
        	  $("#responseAlert").text("You are now friends with " + friendName + ".");
        	  $("#_FriendAlerts").show();
        	  $("#responseAlert").fadeIn();
        	 
        	  // reset timer in case it already started
        	  window.clearTimeout(timeoutHandle);
        	  // close alert after 2 seconds (2000ms)
        	  timeoutHandle = window.setTimeout(function() {
        		  $("#_FriendAlerts").animate({
                      height: 'hide'
               	  });
        	  }, 2000);
        	  /**** SHOW AN ALERT, CLOSE IT AFTER 2 SECONDS ****/
   			  
        	  if(requestCount == 0) // if no more requests left; close whole panel
        	  {
        		  $(this).parentsUntil("#_FriendRequests").animate({
                      height: 'hide'
               	  });
        	  }
        	  else                  // decrease number of requests by 1
        	  {
        		  $("#_RequestCount").html('<i class="fa fa-user-plus" aria-hidden="true"></i> ' + requestCount);
            	  $(this).parentsUntil(".list-group").animate({
                      height: 'hide'
               	  });
        	  } 	  
           });
           
           /* LOGOUT FUNCTION */
           $('#logoutButton').click(function() {     	   
        	   $.ajax({       		   
        		    // The URL for the request
        		    url: "LogoutServlet",      		
  		 
        		    // Whether this is a POST or GET request
        		    type: "POST",
        		 
        		    // The type of data we expect back
        		    //dataType : "json",
        		});
           });
           
           $('#randomMultiple').click(function() {  
        	   console.log("$('#randomMultiple').click triggered.");
 
        	   $.ajax({   		   
        		    // The URL for the request
        		    url: "GameServlet",
        		 
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
        		.done(function( response ) {
        			console.log( response.state);
        			if(response.state == 0) // waiting
        			{
        				setTimeout(function(){		// CHECK IF AN OPPONENT FOUND, EVERY 5 SECONDS
        					$('#randomMultiple').click();
        			    }, 5000);
        			}
        			else if(response.state == 1)
        				window.location.href = "/TestWeb/MultipleChoice.jsp";
        		})
        		.fail(function( xhr, status, errorThrown ) {

    				console.log( "Error: " + errorThrown );
    				console.log( "Status: " + status );
    				console.dir( xhr );
        		}) 		
           });
           
           /* IDLE CHECK */        
           ifvisible.setIdleDuration(600);
           
           // check if the tab is active
           ifvisible.on('statusChanged', function(e){
        //	   console.log(e.status);
               if(e.status == "hidden")
           	   {
           	   		// update database for falan filan
         //  	   		console.log("1");
           	   }
               else if(e.status == "active")
           	   {
					// geri update
        //    	   console.log("2");
           	   }
               else if(e.status == "idle")
       		   {
       	   			// logout
            	   $('#logoutButton').click();
       		   }
           });
           

           
           /* INACTIVE DURATION */ 
           
        //   var dur = (ifvisible.getIdleDuration() / 1000); // in seconds
		
           
        });

        /************************** JQUERY END **************************/  

        
        /* PUT ALL ELEMENTS WITH ID="REQUEST" INTO AN ARRAY AND CHECK IF SOME ELEMENTS ARE IN THAT ARRAY       
          var requestUsers = $("[id=request]").map(function(){return $(this).attr("aria-labelledby");}).get();     
          requestUsers.sort();
       	  console.log(requestUsers);
       	  
       	  if($.inArray("Can Sissoko", requestUsers) > -1)
       	  {
       		  console.log($.inArray("Can Sissoko", requestUsers))
       	  }
       	  
       	  if($.inArray("Cann Sissoko", requestUsers) == -1)
       	  {
       		  console.log($.inArray("Cann Sissoko", requestUsers))
       	  }    
        */
        
        
        /*  CALLING A FUNCTION OVER AND OVER 
        (http://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_clearinterval)
        (http://stackoverflow.com/questions/2170923/whats-the-easiest-way-to-call-a-function-every-5-seconds-in-jquery)
        var myVar = setInterval(function(){ myTimer() }, 1000);

		function myTimer() {
		    var d = new Date();
		    var t = d.toLocaleTimeString();
		    document.getElementById("demo").innerHTML = t;
		}
        */
           
        </script>     
	</body>		
</html>

