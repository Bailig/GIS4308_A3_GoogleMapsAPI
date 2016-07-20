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
                       <h1 class="text-center">
                           <span>B</span>
                           <span>a</span>
                           <span>i</span>
                           <span>l</span>
                           <span>i</span>
                           <span>g</span>
                           <span> </span>
                           <span>A</span>
                           <span>b</span>
                           <span>h</span>
                           <span>a</span>
                           <span>n</span>
                           <span>a</span>
                           <span>r</span>
                       </h1>
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
                            <button type="button" class="btn btn-primary" id="zoom">Hohhot</button>
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
                                    <p>Latitude: <b><%= records("POINT_Y") %></b></p>
                                    <p>Longitude: <b><%= records("POINT_X") %></b></p>
                                </div>
                            </div>
                        <%
                            records.MoveNext();
                            } 
                            
                        %>
                        </div>
                    </div>
                </div>
            </div>
        </article>
        
        <footer>
            <p>Bailig Abhanar | Algonquin College</p>
        </footer>
        
        
	    <script type="text/javascript" src="lib/jquery.min.js"></script>
        <script type="text/javascript" src="lib/jquery.cycle.all.min.js"></script>
        <script type="text/javascript" src="lib/bootstrap.min.js"></script>
        
        <script type="text/javascript">
            var map;
            var historicalOverlay;
            var artifacts = [ 
                <%
                    records.MoveFirst();
                    while (!records.EOF) { 
                    Response.Write("[")
                    Response.Write("\"" + records("Title")  + "\",")
                    Response.Write(records("POINT_Y")  + ", ")
                    Response.Write(records("POINT_X") + ", ")
                    Response.Write("1],")
                    records.MoveNext();
                    }
                %>	
            ];    

            function initMap() {
                map = new google.maps.Map(document.getElementById('map'), {
                    center: {lat: 45.3492, lng: -75.7583},
                    zoom: 10,
                    mapTypeControl: true,
                    mapTypeControlOptions: {
                        style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
                        mapTypeIds: [
                            google.maps.MapTypeId.ROADMAP,
                            google.maps.MapTypeId.TERRAIN,
                            google.maps.MapTypeId.HYBRID,
                            google.maps.MapTypeId.SATELLITE
                        ]
                    },
                    zoomControl: true,
                    zoomControlOptions: {
                        style: google.maps.ZoomControlStyle.LARGE
                    }
                });
                var marker = new google.maps.Marker({
                    position: {lat: 45.38099, lng: -75.69906},
                    map: map,
                    title: 'Loeb Building'
                });
                var info = "<p>The Loeb Building recognizes the financial contributions made to Carleton by Ottawa’s Loeb family. It houses offices for the Faculty of Public Affairs, as well as various academic departments, a cafeteria and lounge, classrooms and laboratories.</p>"
                var infowindow = new google.maps.InfoWindow({
                    content: info
                });
                marker.addListener('click', function() {
                    infowindow.open(map, marker);
                });
                var imageBounds = {
                    north: 45.353244,
                    south: 45.345569,
                    east: -75.741957,
                    west: -75.765587
                };
                historicalOverlay = new google.maps.GroundOverlay(
                      'image/map1.jpg',imageBounds);
                historicalOverlay.setMap(map);

                var geocoder = new google.maps.Geocoder();
                document.getElementById('submit').addEventListener('click', function() {
                    geocodeAddress(geocoder, map);
                });
				
				var infowindow1 = new google.maps.InfoWindow();
				var marker1, i;
                for (i = 0; i < artifacts.length; i++) {
                    marker1 = new google.maps.Marker({
                        position: {lat: artifacts[i][1], lng: artifacts[i][2]} ,
                        map: map,
                        title: artifacts[i][0]
                    });
					google.maps.event.addListener(marker1, 'click', (function(marker1, i) {
						return function() {
						  infowindow1.setContent(artifacts[i][0]);
						  infowindow1.open(map, marker1);
						}
					  })(marker1, i));
					/*let infowindow1 = new google.maps.InfoWindow({
						content: artifacts[i][0]
					});
					marker1.addListener('click', function() {
						infowindow1.open(map, marker1);
					});*/
                }
            }

            function geocodeAddress(geocoder, resultsMap) {
                var address = document.getElementById('address').value;
                geocoder.geocode({'address': address}, function(results, status) {
                    if (status === google.maps.GeocoderStatus.OK) {
                        resultsMap.setCenter(results[0].geometry.location);
                        var marker2 = new google.maps.Marker({
                            map: resultsMap,
                            position: results[0].geometry.location
                        });
                    } else {
                        alert('Geocode was not successful for the following reason: ' + status);
                    }
                });
            }
        </script>
        <script type="text/javascript" src="js/script.js"></script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?v=3.23
        &key=AIzaSyAewu4-e13oVJRDyv-cVJ4a0Vjx0m0LTQc&callback=initMap"></script>
                
        <% 
            records.Close();
            conn.Close();  
        %>
	</body>
</html>