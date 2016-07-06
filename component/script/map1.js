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