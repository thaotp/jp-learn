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
//= require backbone.min
//= require backbone.queryparams
//= require moment
//= require bootstrap-select.min
//= require sweet-alert.min
//= require jquery.serializeObject.min
//= require floatlabels.min.js
//= require bootstrap-editable.min

// Templates
//= require_tree ./public/templates

// Global variables
//= require globals

// JP Libraries
//= require_tree ./lib

// Events Controller
// needs to be initialized early
//= require public/controllers/eventsController

// Helpers
// require_tree ./public/helpers

// Contrors
//= require_tree ./public/controllers

// Models
//= require_tree ./public/models

// Collections
//= require_tree ./public/collections

// Views
//= require_tree ./public/views

// Router
//= require public/router

// Qvoval App, should be last!
//= require public/app
$.fn.editable.defaults.mode = 'inline';