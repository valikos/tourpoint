$(document).ready(function(){
  $('#place_location')
  .live('ajax:before', function(evt, xhr, settings){
    if($('#location_latitude').val !== '' && $('#location_longitude').val() !== ''){
      return false;
    }
  })
  .live('ajax:success', function(evt, data, status, xhr){
    $('#places_location').val('');
    $('#location_latitude').val(data.lat);
    $('#location_longitude').val(data.lng);
    Gmaps.map.addMarkers([{lat: data.lat, lng: data.lng, draggable: true}]);
  });
});