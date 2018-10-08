<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>Examples</title>
<style>
 
  
  #map {
    height: 500px;
    width: 800px;
  }

  </style>

</head>
<body>

  <div>   
    <button id="btn" onclick="searchEve()">�a�Ϸj�M</button>
    <div id="map"></div>
  </div>


<script>
var map;
var markers = [];
var infoWindow ;

 //��l��Map
function initMap() { 	
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 14,
      center: {
        lat: 25.0336962,
        lng: 121.5643673
      }
    });
}


function searchEve(){ 
	  var xhr = new XMLHttpRequest();
	  xhr.onload = function (){
	      if( xhr.status == 200){
	        //document.getElementById("showPanel").innerHTML = xhr.responseText;
	        showEveMarker(xhr.responseText);
	      }else{
	        alert( xhr.status );
	      }//xhr.status == 200
	  };//onload 
	  
	  //�إߦnGet�s��
	  var url= "<%=request.getContextPath() %>/EveMap";
	  xhr.open("Get",url,true); 
	  //�e�X�ШD 
	  xhr.send( null );
}
 
 
 
 
 
function showEveMarker(jsonStr) {
	
	
  	infoWindow = new google.maps.InfoWindow();
    clearMarkers();
   
	var jArray = JSON.parse(jsonStr);
  	console.log(jArray);

	//�N���߳]�b��e��m �����marker
	if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            var marker = new google.maps.Marker({
                position: pos,
                icon:'assets/conference/logo_4.png',
                map: map
            });
            map.setZoom(12);
            map.setCenter(pos);

            // bounds���a�ϥi�Hzoom�H��ܩҦ�marker
            var bounds = new google.maps.LatLngBounds();
		    for (var i = 0; i < jArray.length; i++) {
		      addMarker(i,bounds);
		    }
		    map.fitBounds(bounds);
        });
    } else {
        // Browser doesn't support Geolocation
        alert("�����\�ξD�J���~�I");
    }

	function addMarker(e,bounds) {

		//infowindow�����e
		var html = '<h2>'+ jArray[e].eve_title +'</h2>'+
		 	'<div style="width:200px;">'+
		 	'<a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id='+jArray[e].eve_id+'">'+
		 	'<img class="infoImg"  style="width:100%;" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id='+ jArray[e].eve_id +'"></a></div>';
			    
  		var marker= new google.maps.Marker({
          position: {
            lat: jArray[e].eve_lat,
            lng: jArray[e].eve_long
          },
          map: map,
          animation: google.maps.Animation.DROP
        });

  		//�Nmarker��Jmarkers�}�C �]�winfowindow
	    setTimeout(function() {
	      markers.push(marker);
	    }, e * 150);
	    marker.addListener('click', function() {
	    	 infoWindow.setContent(html);
	   		 infoWindow.open(map, marker);
		});
	    
		bounds.extend({
            lat: jArray[e].eve_lat,
            lng: jArray[e].eve_long
          });

	}


	function clearMarkers() {
		infoWindow.close();		
	    for (var i = 0; i < markers.length; i++) {
	      markers[i].setMap(null);
	    }
	    markers = []; 
	}

}
</script>


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyASI3sgz6P-wisrPe6D4N59Ro0RrodnHJM&callback=initMap" async defer></script>

    
</body>
</html>