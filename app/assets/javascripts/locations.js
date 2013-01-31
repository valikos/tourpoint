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
    dropMarkerAnimation(location);
    rewriteAllPolylines();
  })
  .live('ajax:error', function( xhr, textStatus, errorThrown ){
    var error = JSON.parse(textStatus.responseText);
    var errors = '';
    jQuery.each( error, function( key, value ) {
      errors += '<p>' + key + ": " + value[0] + '</p>';
    });
    $('#main_wrap').prepend('<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">&times;</button>' + errors + '</div>');
  });

  $('#addLocationToTourItenerary').live('click', function(e){
    clearErrorAlert();
    clearSuccessAlert();
    $('#new_location').trigger('submit');
  });

  $('#updateLocationInTourItenerary').live('click', function(e){
    $('.edit_location').trigger('submit');
  });

  $('#closeEditLocationInTourItenerary').live('click', function(e){
    marker = disableEditableMarker();
    marker.serviceObject.setPosition(new google.maps.LatLng(marker.lat, marker.lng));
    $('#action-form').html('').append(window.newLocationForm.children());
  });

  // remove itinerary actions
  $('.remove_itinerary')
  .live('ajax:success', function(evt, data, status, xhr){
    $('#location_' + data.id).remove();
    dropMarker(data.id);
    rewriteSortPolylines();
  });

  // location actions
  // get form
  $('.start_edit_location').
  live('ajax:success', function(evt, data, status, xhr){
    var marker = data[0];
    var form = data[1].action_form;

    setEditableMarker(marker.id);

    draggedMarker(getMarker(marker.id));

    window.newLocationForm = $('#action-form').clone();
    $('#action-form').html(form);
  });
  // location update
  $('.edit_location')
  .live('ajax:success', function(evt, data, status, xhr){

    var marker = disableEditableMarker();
    marker.lat = marker.serviceObject.position.lat();
    marker.lng = marker.serviceObject.position.lng();
    rewriteSortPolylines();

    var location = data[0];
    var view = data[1].partial;
    $('#location_' + location.id).replaceWith(view);
    $('#action-form').html('').append(window.newLocationForm.children());
  })
  .live('ajax:error', function(xhr, textStatus, errorThrown){
    var error = JSON.parse(textStatus.responseText);
    var errors = '';
    jQuery.each( error, function( key, value ) {
      errors += '<p>' + key + ": " + value[0] + '</p>';
    });
    $('#main_wrap').prepend('<div class="alert alert-error"><button type="button" class="close" data-dismiss="alert">&times;</button>' + errors + '</div>');
  });
});

function setEditableMarker(id) {
  var marker;
  $.each(Gmaps.map_canvas.markers, function(index, value) {
    if(id == value.id){
      marker = value;
      return false;
    }
  });
  marker.serviceObject.setAnimation(google.maps.Animation.BOUNCE);
  marker.serviceObject.draggable = true;
  window.editableMarker = marker;
}

function getMarker(id) {
  var marker;
  $.each(Gmaps.map_canvas.markers, function(index, value) {
    if(id == value.id){
      marker = value;
      return false;
    }
  });
  return marker;
}

function disableEditableMarker(){
  var marker = window.editableMarker;
  window.editableMarker = null;
  marker.serviceObject.setAnimation(null);
  marker.serviceObject.draggable = false;
  return marker;
}

function rewriteMapByOrder(){
  var old_markers = Gmaps.map_canvas.markers;
  var markers = [];
  var paths = [[]];

  Gmaps.map_canvas.destroy_polylines();
  Gmaps.map_canvas.replaceMarkers();

  $.each($('table#tour_locations_list tbody tr'), function(index, value) {
    var id = value.id.split('_')[1];
    $.each(old_markers, function(index, marker) {
      if(id == marker.id){
        markers.push(marker);
        paths[0].push(marker);
      }
    });
  });

  Gmaps.map_canvas.markers = markers;
  console.log(Gmaps.map_canvas.markers);
  Gmaps.map_canvas.markers_conf.rich_marker = true;
  Gmaps.map_canvas.create_markers();

  Gmaps.map_canvas.polylines = paths;
  Gmaps.map_canvas.create_polylines();
}