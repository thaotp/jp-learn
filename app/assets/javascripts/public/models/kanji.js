/* */

$(function() {

  'use strict';

  JP.Models.Kanji = Backbone.Model.extend({

    toJSON: function() {
      var attrs = _.clone(this.attributes);

      return attrs;
    },

    urlRoot: JP.Globals.apiPath('kanjis')

  });

});