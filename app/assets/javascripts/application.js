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
//= require jquery_ujs
//= require gmaps
//= require twitter/bootstrap
//= require bootstrap-datepicker/core
//= require_tree .

  // var path = [];

  // $('.add-marker').on('click', function(e){
  //   var pos = map.getCenter();

  //   map.addMarker({
  //     lat: pos.lat(),
  //     lng: pos.lng(),
  //     draggable: true
  //   });

  //   path.push([pos.lat(), pos.lng()]);

  //   var allMarkers = map.markers;

  //   if (allMarkers.length > 1) {
  //     console.log(allMarkers);
  //     map.drawPolyline({
  //       path: path,
  //       strokeColor: '#000000',
  //       strokeOpacity: 1.0,
  //       strokeWeight: 3
  //     });
  //   }
  // });

  // $('.markers').on('click', function(e){

  // });

$(document).ready(function(e){

  if ($('#test_map').length) {

    map = new GMaps({
      div: '#test_map',
      lat: 41.8781136,
      lng: -87.6297982
    });

    $('#add-marker').on('click', function(e){
      e.preventDefault();
      var pos = map.getCenter();
      $('#location_latitude').val(pos.lat());
      $('#location_longitude').val(pos.lng());
      map.addMarker({
        lat: pos.lat(),
        lng: pos.lng(),
        draggable: true
      });
    });


/* Example

$('#create_comment_form')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      var $submitButton = $(this).find('input[name="commit"]');

      // Update the text of the submit button to let the user know stuff is happening.
      // But first, store the original text of the submit button, so it can be restored when the request is finished.
      $submitButton.data( 'origText', $(this).text() );
      $submitButton.text( "Submitting..." );

    })
    .bind("ajax:success", function(evt, data, status, xhr){
      var $form = $(this);

      // Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
      $form.find('textarea,input[type="text"],input[type="file"]').val("");
      $form.find('div.validation-error').empty();

      // Insert response partial into page below the form.
      $('#comments').append(xhr.responseText);

    })
    .bind('ajax:complete', function(evt, xhr, status){
      var $submitButton = $(this).find('input[name="commit"]');

      // Restore the original submit button text
      $submitButton.text( $(this).data('origText') );
    })
    .bind("ajax:error", function(evt, xhr, status, error){
      var $form = $(this),
          errors,
          errorText;

      try {
        // Populate errorText with the comment errors
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
        errors = {message: "Please reload the page and try again"};
      }

      // Build an unordered list from the list of errors
      errorText = "There were errors with the submission: \n<ul>";

      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      }

      errorText += "</ul>";

      // Insert error list into form
      $form.find('div.validation-error').html(errorText);
    });
*/

    $('#new_location')
    .live('ajax:before', function(e){
      // console.log(e);
    })
    .live('ajax:loading', function(e){
      // console.log(e);
    })
    .live('ajax:success', function(evt, data, status, xhr){
      $('table#tour_locations_list')
      .append("<tr>\
                <td>№</td>\
                <td>" + data.title + "</td>\
              </tr>");




      console.log(evt, data, status, xhr);
    })
    .live('ajax:complete', function(e){
      // console.log(e);
    })
    .live('ajax:after', function(e){
      // console.log(e);
    });

  }

  $(document).on("focus", "[data-behaviour~='datepicker']", function(e){
      $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true});
  });

});
