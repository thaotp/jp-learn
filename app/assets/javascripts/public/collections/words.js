$(function() {

  'use strict';

  JP.Collections.Words = Backbone.Collection.extend({

    model: JP.Models.Word,

    url: JP.Globals.apiPath('words')

  });

});