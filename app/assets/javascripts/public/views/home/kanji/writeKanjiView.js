/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.WriteKanjiView = Backbone.View.extend({

    events: {
      'click .js-click': 'changeKanji',
      'click .js-easer': 'easerBackground',
    },

    template: JP.Templates['public/templates/kanji/write'],

    initialize: function() {
      this.setElement(JP.Globals.contentElement);
      this.listenToOnce(this, 'ready', _.bind(this.onReady, this));
      this.fetchCollection();
    },

    onReady: function() {
      this.render();
      this.simpleBoard = new DrawingBoard.Board('simple-board', {
        controls: false,
        webStorage: false,
        size: 5
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

    changeKanji: function(e){
      e.preventDefault();
      this.simpleBoard.resetBackground();
      var id = $(e.currentTarget).data('id')
      var model = this.collection.get(id)
      this.$('.js-x').each(function(index, el){
        var kind = $(el).data('kind')
        $(el).html(model.get(kind))
        if(kind=='image'){
          $(el).attr("src", model.get(kind));
        }
      });
    },

    easerBackground: function(e){
      e.preventDefault();
      this.simpleBoard.resetBackground()
    },

    onClose: function() {
      this.unbindEvents();
    }

  });

});
