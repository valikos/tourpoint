$(document).ready(function(){
  $('#new_location')
  // .live('ajax:before', function(e){
  //   // console.log(e);
  // })
  // .live('ajax:loading', function(e){
  //   // console.log(e);
  // })
  // .live('ajax:complete', function(e){
  //   // console.log(e);
  // })
  // .live('ajax:after', function(e){
  //   // console.log(e);
  // })
  // .live('ajax:failure', function(e){
  //   console.log('failure');
  // })
  .live('ajax:success', function(evt, data, status, xhr){
    $('table#tour_locations_list')
    .append("<tr>\
              <td>№</td>\
              <td><strong>" + data.title + "</strong>\
              <br />" + data.description + "</td>\
            </tr>");
    resetLocationForm();
    $('#main_wrap').prepend('<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Added</div>');
  })
  .live('ajax:error', function( xhr, textStatus, errorThrown ){
    var error = JSON.parse(textStatus.responseText);
    var errors = '';
    jQuery.each( error, function( key, value ) {
      errors += '<p>' + key + ": " + value[0] + '</p>';
    });
    $('#main_wrap').prepend('<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">&times;</button>' + errors + '</div>');
  });

  $('#addLocationToTourItenerary').bind('click', function(e){
    $('#new_location').trigger('submit');
  });
});

  // $('#add-marker').on('click', function(e){
  //   e.preventDefault();
  //   var position = Gmaps.map.map.getCenter();
  //   updateLocationPosition(position);
  //   var marker = new google.maps.Marker({
  //     position: position,
  //     title:"Hello World!",
  //     draggable: true
  //   });
  //   google.maps.event.addListener(marker, 'dragend', function(pos){
  //     updateLocationPosition(pos.latLng);
  //   });
  //   marker.setMap(Gmaps.map.map);
  // });