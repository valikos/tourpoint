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
            "<input type=\"radio\" data-location=\"" + data[i].name + "\" data-lat=\"" + data[i].position.lat + "\" data-lng=\"" + data[i].position.lng + "\" name=\"optionsRadios\" id=\"optionsRadios" + i + "\" value=\"" + i + "\" >" +
            data[i].name +
          "</label>"
        );
      }
      $('#location-select').modal({
        keyboard: false
      });
    } else if (data instanceof Array && data.length === 1) {
      lat = data[0].position.lat;
      lng = data[0].position.lng;
      if($('#new_location').length){
        addNewLocationMarker(lat, lng);
      }else{
        replaceMarkerPosition(lat, lng);
      }
    }
  });
});
