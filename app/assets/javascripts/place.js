$(document).ready(function(){
  $('#save-location-select').on('click', function(e){
    var item = $('input[name=optionsRadios]:checked');
    if (item.length) {
      $('div#location-select').modal('hide');
      var editItem = $('[id^="edit_location_"]');
      if(editItem.length){
        var id = editItem[0].id.split('_')[2];
        var marker = getMarker(id);
        if(marker){
          replaceMarkerPosition($(item).data('lat'), $(item).data('lng'));
        }else{
          addNewLocationMarker($(item).data('lat'), $(item).data('lng'));
        }
      } else {
        addNewLocationMarker($(item).data('lat'), $(item).data('lng'));
      }
      $('#places_location').val($(item).data('location'));
    }
  });

  $('#place_location')
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
      $('div#location-select').modal({
        keyboard: false
      });
    } else if (data instanceof Array && data.length === 1) {
      lat = data[0].position.lat;
      lng = data[0].position.lng;
      var editItem = $('[id^="edit_location_"]');
      if(editItem.length > 0){
        var id = editItem[0].id.split('_')[2];
        var marker = getMarker(id);
        if(marker){
          replaceMarkerPosition(lat, lng);
        }else{
          addNewLocationMarker(lat, lng);
        }
      } else {
        addNewLocationMarker(lat, lng);
      }
    }
  })
  .live('ajax:error', function( xhr, textStatus, errorThrown ){
    if($('div#alert-error').length === 0){
      $('div#location-status').prepend(
        "<div class=\"alert alert-error\" id=\"alert-error\">" +
        "Location not found" +
        "<div/>"
      );
    }
  });
});
