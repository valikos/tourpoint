$(document).ready(function(){
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
  $('#new_location')
  .live('ajax:success', function(evt, data, status, xhr){
    var location = data[0];
    var partial = data[1].partial;
    $('table#tour_locations_list').append(partial);
    // $('#main_wrap').prepend('<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Added</div>');

    resetLocationForm();

    // drop animation

    var marker = Gmaps.map_canvas.markers[Gmaps.map_canvas.markers.length - 1];
    marker.draggable = false;
    marker.serviceObject.draggable = false;
    marker.id = location.id;
    marker.order = location.order;
    marker.serviceObject.setAnimation(null);
    var polylines = Gmaps.map_canvas.polylines;
    polylines[0].push({
      lat: marker.serviceObject.position.lat(),
      lng: marker.serviceObject.position.lng()
    });
    Gmaps.map_canvas.destroy_polylines();
    Gmaps.map_canvas.polylines = polylines;
    Gmaps.map_canvas.create_polylines();
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
    clearErrorAlert();
    clearSuccessAlert();
    $('#new_location').trigger('submit');
  });

  $('.button_to')
  .live('ajax:success', function(evt, data, status, xhr){
    $('#location_' + data.id).remove();
    dropMarker(data.id);
    rewritePolylines();
  });
});
