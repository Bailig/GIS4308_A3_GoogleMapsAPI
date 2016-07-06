var map;
var historicalOverlay;

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
}// initMap

function geocodeAddress(geocoder, resultsMap) {
    var address = document.getElementById('address').value;
    geocoder.geocode({'address': address}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
            resultsMap.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
                map: resultsMap,
                position: results[0].geometry.location
            });
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

$('#algponquin').on("click",function(){
    map.setCenter({lat: 45.3492, lng: -75.7583});
    map.setZoom(18);
});
$('#parliament').on("click",function(){
    map.setCenter({lat: 45.4236, lng: -75.7009});
    map.setZoom(18);
    map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
});
$('#ottawaRoad').on("click",function(){
    map.setCenter({lat: 45.3492, lng: -75.7583});
    map.setZoom(10);
    map.setMapTypeId(google.maps.MapTypeId.ROADMAP);
});
$('#zoom').on("click",function(){
    map.setZoom(map.getZoom()+1);
});
$('#address').on("focus blur",function(){
    $('.input-group').toggleClass('focus');
});