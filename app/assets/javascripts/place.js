function draggedMarker(marker) {
  google.maps.event.addListener(marker.serviceObject, 'dragend', function(pos){
    updateLocationPosition(pos.latLng);
  });
}

function addNewLocationMarker(lat, lng){
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

  draggedMarker(marker);

  if($('div#alert-success').length === 0){
    $('div#location-status').prepend(
      "<div class=\"alert alert-success\" id=\"alert-success\">" +
      "Click the map or drag the marker to adjust location" +
      "<div/>"
    );
  }
}

function replaceMarkerPosition(lat, lng){
  var marker = window.editableMarker;
  marker.serviceObject.setPosition(new google.maps.LatLng(lat, lng));
  $('#location_latitude').val(lat);
  $('#location_longitude').val(lng);
}

function clearErrorAlert(){
  if($('div#alert-error').length === 1){
    $('div#alert-error').remove();
  }
}

function clearSuccessAlert(){
  if($('div#alert-success').length === 1){
    $('div#alert-success').remove();
  }
}

$(document).ready(function(){

  $('#save-location-select').on('click', function(e){
    var item = $('input[name=optionsRadios]:checked');
    if (item.length) {
      $('div#location-select').modal('hide');

      // addNewLocationMarker($(item).data('lat'), $(item).data('lng'));

      if($('#new_location').length){
        addNewLocationMarker($(item).data('lat'), $(item).data('lng'));
      }else{
        replaceMarkerPosition($(item).data('lat'), $(item).data('lng'));
      }

      $('#places_location').val($(item).data('location'));
    }
  });

  $('#place_location')
  .live('ajax:before', function(evt, xhr, settings){
    // if($('#location_latitude').val !== '' && $('#location_longitude').val() !== ''){
    //   return false;
    // }
  })
  .live('ajax:error', function( xhr, textStatus, errorThrown ){
    if($('div#alert-error').length === 0){
      $('div#location-status').prepend(
        "<div class=\"alert alert-error\" id=\"alert-error\">" +
        "Location not found" +
        "<div/>"
      );
    }
  })
  .live('ajax:success', function(evt, data, status, xhr){
    dropUndefinedMarker();
    clearErrorAlert();
    var lat, lng;
    if (data instanceof Array && data.length > 1) {
      $('div#location-select-option').html('');
      for (var i in data) {
        $('div#location-select-option').append(
          "<label class=\"radio\">" +
            "<input type=\"radio\" data-location=\"" + data[i].data.formatted_address + "\" data-lat=\"" + data[i].data.geometry.location.lat + "\" data-lng=\"" + data[i].data.geometry.location.lng + "\" name=\"optionsRadios\" id=\"optionsRadios" + i + "\" value=\"" + i + "\" >" +
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
      if($('#new_location').length){
        addNewLocationMarker(lat, lng);
      }else{
        replaceMarkerPosition(lat, lng);
      }
    }
  });
});
