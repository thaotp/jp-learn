/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.WriteKanjiView = Backbone.View.extend({

    events: {
      'click .js-reset': 'resetBackground',
    },

    template: JP.Templates['public/templates/kanji/write'],

    initialize: function() {
      this.setElement(JP.Globals.contentElement);
      this.listenToOnce(this, 'ready', _.bind(this.onReady, this));
      this.fetchCollection();
    },

    onReady: function() {
      this.render();
      var simpleBoard = new DrawingBoard.Board('simple-board', {
        controls: false,
        webStorage: false,
        size: 2
      });
      this.bindEvents();
    },

    bindEvents: function() {
      return this;
    },

    unbindEvents: function() {
      this.stopListening();
      return this;
    },

    getContext: function() {
      var context = {};

      context.JP = JP;
      context.kanjis = this.collection.toJSON()

      return context;
    },

    render: function() {
      this.$el.html(this.template(this.getContext()));
      return this;
    },

    fetchCollection: function(){

      var _this = this;

      this.collection = new JP.Collections.Kanjis();
      var req = this.collection.fetch();

      req.fail(function() {
        console.log("fail")
      });

      req.done(function(e) {
        _this.trigger('ready');
      });

    },


    onClose: function() {
      this.unbindEvents();
    }

  });

});
