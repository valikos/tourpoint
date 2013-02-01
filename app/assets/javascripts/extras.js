function updateLocationPosition(map){
  $('#location_latitude').val(map.lat());
  $('#location_longitude').val(map.lng());
}

function resetLatLng() {
  $('#location_latitude').val('');
  $('#location_longitude').val('');
}

function resetLocationForm() {
  $('#location_title').val('');
  $('#location_description').val('');
  $('#location_latitude').val('');
  $('#location_longitude').val('');
  $('#places_location').val('');
}

function dropMarker(id) {
  var markers = [];
  var remove;
  $.each(Gmaps.map_canvas.markers, function(index, value) {
    if(id == value.id){
      value.serviceObject.setMap(null);
      remove = index;
    }
  });
  Gmaps.map_canvas.markers.splice(remove, 1);
}

function dropUndefinedMarker() {
  if(Gmaps.map_canvas.markers.length){
    var last = Gmaps.map_canvas.markers.length - 1;
    var marker = Gmaps.map_canvas.markers[last];
    if (typeof marker.id === "undefined") {
      marker.serviceObject.setMap(null);
      Gmaps.map_canvas.markers.splice(last, 1);
    }
  }
}

function rewriteAllPolylines() {
  var new_paths = [Gmaps.map_canvas.markers];
  Gmaps.map_canvas.destroy_polylines();
  Gmaps.map_canvas.polylines = new_paths;
  Gmaps.map_canvas.create_polylines();
}

function rewriteSortPolylines() {
  var new_paths = [[]];
  $.each($('table#tour_locations_list tbody tr'), function(index, value) {
    var id = value.id.split('_')[1];
    $.each(Gmaps.map_canvas.markers, function(index, marker) {
      if(id == marker.id){
        new_paths[0].push(marker);
      }
    });
  });
  Gmaps.map_canvas.destroy_polylines();
  Gmaps.map_canvas.polylines = new_paths;
  Gmaps.map_canvas.create_polylines();
}

function dropMarkerAnimation(location, infowindow){
  // drop animation and set option
  if(location.latitude && location.longitude && Gmaps.map_canvas.markers.length){
    var marker = Gmaps.map_canvas.markers[Gmaps.map_canvas.markers.length - 1];
    marker.draggable = false;
    marker.serviceObject.draggable = false;
    marker.id = location.id;
    marker.order = location.order;
    marker.serviceObject.setAnimation(null);
    marker.infowindow.content = infowindow;
  }
}

var fixHelper = function(e, ui) {
  ui.children().each(function() {
    $(this).width($(this).width());
  });
  return ui;
};

function setEditableMarker(id) {
  var marker;
  $.each(Gmaps.map_canvas.markers, function(index, value) {
    if(id == value.id){
      marker = value;

      draggedMarker(marker);

      marker.serviceObject.setAnimation(google.maps.Animation.BOUNCE);
      marker.serviceObject.draggable = true;
      window.editableMarker = marker;

      return false;
    }
  });
}

function getMarker(id) {
  var marker = false;
  $.each(Gmaps.map_canvas.markers, function(index, value) {
    if(id == value.id){
      marker = value;
      return marker;
    }
  });
  return marker;
}

function disableEditableMarker(){
  var marker = window.editableMarker;
  if(marker){
    window.editableMarker = undefined;
    marker.serviceObject.setAnimation(null);
    marker.serviceObject.draggable = false;
  }
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

function draggedMarker(marker) {
  if(marker){
    google.maps.event.addListener(marker.serviceObject, 'dragend', function(pos){
      updateLocationPosition(pos.latLng);
    });
  }
}

function addNewLocationMarker(lat, lng){
  $('#location_latitude').val(lat);
  $('#location_longitude').val(lng);

  var markers = [];

  var markerOpt = {
    description: '',
    lat: lat,
    lng: lng,
    draggable: true
  };

  if(window.markerId){
    markerOpt.id = window.markerId.id;
    markerOpt.order = window.markerId.order;
  }

  markers.push(markerOpt);

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