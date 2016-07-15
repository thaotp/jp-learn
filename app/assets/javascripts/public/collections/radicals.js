$(function() {

  'use strict';

  JP.Collections.Radicals = Backbone.Collection.extend({

    model: JP.Models.Radical,

    url: JP.Globals.apiPath('radicals')

  });

});