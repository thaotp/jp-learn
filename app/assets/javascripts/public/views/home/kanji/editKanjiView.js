/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.EditKanjiView = Backbone.View.extend({

    events: {
      'click .js-create': 'createQ',
    },

    template: JP.Templates['public/templates/kanji/edit'],

    initialize: function() {
      this.setElement(JP.Globals.contentElement);
      this.listenToOnce(this, 'ready', _.bind(this.onReady, this));
      this.fetchCollection();
    },

    onReady: function() {
      this.render();
      var _this = this;
      this.$('.js-explain').editable({
        type: 'text',
        success: function(response, newValue) {
          var model = _this.collection.get($(this).data('id'))
          model.set('explain', newValue)
          if(JP.Editable) model.save()
        }
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
