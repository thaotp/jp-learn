/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.HomeView = Backbone.View.extend({

    events: {
      'click .js-create': 'createQ',
    },

    template: JP.Templates['public/templates/home/home'],

    initialize: function() {
      this.setElement(JP.Globals.contentElement);
      this.listenToOnce(this, 'ready', _.bind(this.onReady, this));
      // this.trigger('ready');
      this.fetchCollection();
    },

    onReady: function() {
      this.render();
      this.startWord();
      this.bindEvents();
    },

    bindEvents: function() {
      this.listenTo(JP.events, 'next:word', _.bind(this.nextWord, this));
      return this;
    },

    unbindEvents: function() {
      this.stopListening();
      return this;
    },

    getContext: function() {
      var context = {};

      context.JP = JP;

      return context;
    },

    render: function() {
      this.$el.html(this.template(this.getContext()));
      return this;
    },

    fetchCollection: function(){

      var _this = this;
      var type = null;

      this.collection = new JP.Collections.Words();
      var req = this.collection.fetch({ data: $.param({ times: JP.Times}) });

      req.fail(function() {
        console.log("fail")
      });

      req.done(function(e) {
        _this.trigger('ready');
      });

    },

    startWord: function(){
      var model = this.collection.first();
      if(_.isUndefined(model)) return;
      this.positionWord = 0;
      this.currentWordView = this.initWordView(model);
    },

    nextWord: function(){
      this.positionWord++
      if(this.currentWordView != null){
        this.currentWordView.close();
        this.currentWordView = null;
      }
      var model = this.getModelNextWord(this.positionWord);
      this.currentWordView = this.initWordView(model);
      $('.js-input').focus();
    },

    initWordView: function(model){
      if(_.isUndefined(model)){
        if(this.isReview){
          location.reload();
          return;
        }
        model = this.collection.first();
        this.positionWord = 0;
      }

      var wordView = new JP.Views.ShowWordView({
        model: model
      });

      this.$('.js-word-wrap').append(wordView.render().el);


      return wordView;
    },

    getModelNextWord: function(position){
      return this.collection.at(position);
    },

    onClose: function() {
      this.unbindEvents();
    }

  });

});
