/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.WordView = Backbone.View.extend({

    events: {
      'submit .js-form': 'submitForm',
    },

    tagName: 'article',

    template: JP.Templates['public/templates/word/edit'],
    templateShow: JP.Templates['public/templates/word/show'],

    initialize: function() {
      this.setElement(JP.Globals.contentElement);
      this.listenToOnce(this, 'ready', _.bind(this.onReady, this));
      this.model = new JP.Models.Word();
      this.trigger('ready');
    },

    onReady: function() {
      this.render();
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
      context.word = this.model.toJSON();
      return context;
    },

    render: function() {
      this.$el.html(this.template(this.getContext()));
      return this;
    },

    renderShow: function(){
      this.$el.html(this.templateShow(this.getContext()));
      return this;
    },

    nextWord: function(e){
      e.preventDefault();
      JP.events.trigger('next:word');
    },

    submitForm: function(e){
      e.preventDefault();
      this.model.set( this.$('.js-form').serializeObject() )
      // console.log( JSON.stringify( this.$('.js-form').serializeObject() ) )
      var req = this.model.save();

      req.fail(function() {
        console.log("fail")
      });

      req.done(function(e) {
        $('.js-form')[0].reset();
      });
    },

    onClose: function() {
      // this.remove();
      this.unbindEvents();
    }

  });

});
