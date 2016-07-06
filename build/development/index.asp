<!DOCTYPE html>
<%@ Language=JavaScript%> 
<html lang="en">
	<head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Bailig Abhanar</title>
		
		<% 
            conn = Server.CreateObject("ADODB.Connection"); 
            conn.Open("DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" +  Server.MapPath("MuseumArtifacts.mdb"));
            records = conn.Execute("SELECT * FROM bai00022_POI_WGS");
        %>
    
		<link rel="stylesheet" type="text/css" href="lib/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="lib/flat-ui.min.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
	</head>
	<body data-spy="scroll" data-target=".navbar" data-offset="50">
		<header id="home">
          <nav class="navbar navbar-inverse" role="navigation" data-spy="affix" data-offset-top="600">
		    <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                       <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span> 
                    </button>
                    <a class="navbar-brand" href="#home">Bailig Abnahar</a>
                </div>
		    
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#home">Home</a></li>
                        <li><a href="#mapPage">Google Map</a></li>
                        <li><a href="#moreInfoPage">More Information</a></li>
                    </ul>
                 </div>
			  </div>
		   </nav>
          
           <div class="container">
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                       <h1 class="text-center">Bailig Abhanar</h1>
                        <p class="text-center">This website is for the cource Web GIS Applications (GIS4308) Assignment03 Google Maps API.</p>
                        <p class="text-center" id="doneArrow"><a href="#mapPage"><span class="glyphicon glyphicon-menu-down"></span></a></p>
                    </div>
                    <div class="col-md-1"></div>
                </div>
           </div>
		</header>
       
        <article id="mapPage" class="container">
            <div class="row">
                <div class="col-md-10 col-sm-12 col-md-push-1">
                    <h2 class="text-center">Google Map</h2>
                    <div class="btn-group btn-group-justified" role="group" aria-labol="...">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-primary" id="algponquin">Algonquin College</button>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-primary" id="parliament">Parliament Hill</button>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-primary" id="ottawaRoad">Ottawa Road Map</button>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-primary" id="zoom">Zoom</button>
                        </div>
                    </div>
                    <div id="floating-panel" class="input-group">
                        <input class="form-control" id="address" type="text" placeholder="Search for...">
                        <span class="input-group-btn">
                            <button type="submit" class="btn" id="submit"><span class="fui-search"></span></button>
                        </span>
                    </div>    
                    <div id="map"></div>
                </div>
            </div>
        </article>
        
        <article id="moreInfoPage" class="container">
           <div class="row">
                <div class="col-md-10 col-sm-12 col-md-push-1">
                    <h2 class="text-center">More Information</h2>
                    <div id="slideshowBox">
                        <a href="#" id="prev_btn">&laquo;</a>
                        <a href="#" id="next_btn">&raquo;</a>
                        <div id="slideshow">

                        <% 
                            while (!records.EOF) { 
                        %> 
                            <div class="slides">
                                <h3 class="title">
                                    <%= records("Title") %>
                                </h3>
                                <div class="imgBox">
                                    <img src="<%= records("Pic_URL") %>" alt="Picture of <%= records("Title") %>">
                                </div>
                                <div class="pBox">
                                    <p>My ID: <b><%= records("MyID") %></b></p>
                                    <p>Contributor: <b><%= records("Contributor") %></b></p>
                                    <p>Description: <b><%= records("Short_Desc") %></b></p>
                                    <p>Latitude: <b><%= records("POINT_Y") %></b></p>
                                    <p>Longitude: <b><%= records("POINT_X") %></b></p>
                                </div>
                            </div>
                        <%
                            records.MoveNext();
                            } 
                            records.Close();
                            conn.Close(); 
                        %>
                        </div>
                    </div>
                </div>
            </div>
        </article>
        
        <footer></footer>
        
        
	    <script type="text/javascript" src="lib/jquery.min.js"></script>
        <script type="text/javascript" src="lib/jquery.cycle.all.min.js"></script>
        <script type="text/javascript" src="lib/bootstrap.min.js"></script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?v=3.23
        &key=AIzaSyAewu4-e13oVJRDyv-cVJ4a0Vjx0m0LTQc&callback=initMap"></script>
        <script type="text/javascript" src="js/script.js"></script>
	</body>
</html>