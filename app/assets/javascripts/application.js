// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker/core
//= require_tree .

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
  var last = Gmaps.map_canvas.markers.length - 1;
  var marker = Gmaps.map_canvas.markers[last];
  if (typeof marker.id === "undefined") {
    marker.serviceObject.setMap(null);
    Gmaps.map_canvas.markers.splice(last, 1);
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

function dropMarkerAnimation(location){
  // drop animation and set option
  var marker = Gmaps.map_canvas.markers[Gmaps.map_canvas.markers.length - 1];
  marker.draggable = false;
  marker.serviceObject.draggable = false;
  marker.id = location.id;
  marker.order = location.order;
  marker.serviceObject.setAnimation(null);
}

var fixHelper = function(e, ui) {
  ui.children().each(function() {
    $(this).width($(this).width());
  });
  return ui;
};

$(document).ready(function(e){

  $("#tour_start_date").datepicker({
    'format': 'yyyy-mm-dd',
    'weekStart': 0,
    'autoclose': true
  });
  $("#tour_end_date").datepicker({
    'format': 'yyyy-mm-dd',
    'weekStart': 0,
    'autoclose': true
  });
  // $(document).on("focus", "[data-behaviour~='datepicker']", function(e){
  //   $(this).datepicker({
  //     format: "yyyy-mm-dd",
  //     weekStart: 0,
  //     autoclose: true
  //   });
  // });

  $('table#tour_locations_list tbody').sortable({
    axis: 'y',
    handle: '.drag-handle',
    update: function(){
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
      rewriteSortPolylines();
    },
    helper: fixHelper
  });
});
