function addNewLocationMarker(lat, lng){
  $('#places_location').val('');
  $('#location_latitude').val(lat);
  $('#location_longitude').val(lng);

  var markers = [];
  markers.push({
    lat: lat,
    lng: lng,
    draggable: true
  });

  Gmaps.map_canvas.addMarkers(markers);

  var marker = Gmaps.map_canvas.markers[Gmaps.map_canvas.markers.length - 1];
  marker.serviceObject.setAnimation(google.maps.Animation.BOUNCE);

  $('div#location-status').prepend('<p>Click the map or drag the marker to adjust location</p>');
}

$(document).ready(function(){

    $('#save-location-select').on('click', function(e){
      var item = $('input[name=optionsRadios]:checked');
      if (item.length) {
        $('div#location-select').modal('hide');
        addNewLocationMarker($(item).data('lat'), $(item).data('lng'));
      }
    });

  $('#place_location')
  .live('ajax:before', function(evt, xhr, settings){
    if($('#location_latitude').val !== '' && $('#location_longitude').val() !== ''){
      return false;
    }
  })
  .live('ajax:error', function( xhr, textStatus, errorThrown ){

    $('div#location-status').prepend('<p>Location not found</p>');

  })
  .live('ajax:success', function(evt, data, status, xhr){
    var lat, lng;

    if (data instanceof Array && data.length > 1) {

      $('div#location-select-option').html('');

      for (var i in data) {
        $('div#location-select-option').append(
          "<label class=\"radio\">" +
            "<input type=\"radio\" data-lat=\"" + data[i].data.geometry.location.lat + "\" data-lng=\"" + data[i].data.geometry.location.lng + "\" name=\"optionsRadios\" id=\"optionsRadios" + i + "\" value=\"" + i + "\" >" +
            data[i].data.formatted_address +
          "</label>"
        );
      }

      $('#location-select').modal({
        keyboard: false
      });
    } else if (data instanceof Array && data.length === 1) {
      lat = data[0].data.geometry.location.lat;
      lng = data[0].data.geometry.location.lng;
      addNewLocationMarker(lat, lng);
    }
  });
});