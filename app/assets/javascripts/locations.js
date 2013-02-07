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

    resetLocationForm();
    dropMarkerAnimation(location, data[1].infovindow);
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
    $('[id^=edit_location_]').trigger('submit');
  });

  $('#closeEditLocationInTourItenerary').live('click', function(e){
    marker = getMarker(window.editedLocation.id);
    disableEditableMarker(marker);
    if(marker){
      marker.serviceObject.setPosition(new google.maps.LatLng(window.editedLocation.latitude, window.editedLocation.longitude));
    }
    $('#action-form').html('').append(window.newLocationForm.children());

    window.editedLocation = undefined;
    window.newLocationForm = undefined;

    clearSuccessAlert();
  });

  // remove itinerary
  $('.remove_itinerary')
  .live('ajax:success', function(evt, data, status, xhr){
    $('#location_' + data.id).remove();
    dropMarker(data.id);
    rewriteSortPolylines();
  });

  // build edition form
  $('.start_edit_location')
  .live('ajax:success', function(evt, data, status, xhr){
    disablePreviousMarker();
    var marker = data[0];
    var form = data[1].action_form;
    window.editedLocation = marker;

    if(getMarker(data[0].id)){
      setEditableMarker(marker.id);
    }

    if (window.newLocationForm == null) {
      window.newLocationForm = $('#action-form').clone();
    }
    // set new form
    $('#action-form').html(form);
    if($('div#alert-success').length === 0){
      $('div#location-status').prepend(
        "<div class=\"alert alert-success\" id=\"alert-success\">" +
        "Click the map or drag the marker to adjust location" +
        "<div/>"
      );
    }
  });

  // location update
  $('[id^=edit_location_]')
  .live('ajax:success', function(evt, data, status, xhr){
    var marker = getMarker(window.editedLocation.id);
    disableEditableMarker(marker);

    if(marker){
      marker.lat = marker.serviceObject.position.lat();
      marker.lng = marker.serviceObject.position.lng();
      marker.infowindow.content = data[1].infowindow;
      rewriteSortPolylines();
    }

    var location = data[0];
    var view = data[1].partial;
    $('#location_' + location.id).replaceWith(view);
    $('#action-form').html('').append(window.newLocationForm.children());

    window.editedLocation = undefined;
    window.newLocationForm = undefined;

    clearSuccessAlert();
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