// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require underscore.min
//= require moment
//= require bootstrap-select.min
//= require sweet-alert.min
//= require jquery.serializeObject.min
//= require floatlabels.min.js
//= require bootstrap-editable.min
//= require drawingboard.min
//= require soundmanager2-jsmin
//= require bar-ui.js
//= require main.js
//= require unslider-min.js
$( document ).ready(function() {
  $('.inline-edit').editable({
      mode: 'inline',
      type: 'textarea',
      showbuttons: false,
      autotext: 'auto',
      pk: 1,
      onblur: 'submit',
      params: function(params) {
        params.attribute = $(this).data('attribute')
        params.class = $(this).data('class')
        return params;
      },
      ajaxOptions: {
        type: 'put',
        dataType: 'json'
      },
      success: function(response, newValue) {
        $(this).val(newValue)
      }
  });
});

