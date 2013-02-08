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
//= require extras
//= require_tree .

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

  $('table#tour_locations_list tbody').sortable({
    axis: 'y',
    handle: '.drag-handle',
    update: function(){
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
      rewriteSortPolylines();
    },
    helper: fixHelper
  });

  /* scroller */
  $(window).scroll(function(){
    if ($(this).scrollTop() > 100) {
      $('.scrollup').fadeIn(700);
    } else {
      $('.scrollup').fadeOut(700);
    }
  });

  $('.scrollup').click(function(e){
    e.preventDefault();
    $("html, body").animate({ scrollTop: 0 }, 600);
  });
});
