$(function() {

  'use strict';

  JP.Collections.Kanjis = Backbone.Collection.extend({

    model: JP.Models.Kanji,

    url: JP.Globals.apiPath('kanjis')

  });

});