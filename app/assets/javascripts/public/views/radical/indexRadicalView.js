/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.IndexRadicalView = Backbone.View.extend({

    events: {
      'click .js-create': 'createQ',
    },

    template: JP.Templates['public/templates/radical/index'],

    initialize: function() {
      this.setElement(JP.Globals.contentElement);
      this.listenToOnce(this, 'ready', _.bind(this.onReady, this));
      // this.trigger('ready');
      this.fetchCollection();
    },

    onReady: function() {
      this.render();
      this.startRadical();
      this.bindEvents();
    },

    bindEvents: function() {
      this.listenTo(JP.events, 'next:radical', _.bind(this.nextRadical, this));
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

      this.collection = new JP.Collections.Radicals();
      var req = this.collection.fetch();

      req.fail(function() {
        console.log("fail")
      });

      req.done(function(e) {
        _this.trigger('ready');
      });

    },

    startRadical: function(){
      var model = this.collection.first();
      if(_.isUndefined(model)) return;
      this.positionRadical = 0;
      this.currentRadicalView = this.initRadicalView(model);
    },

    nextRadical: function(){
      this.positionRadical++
      if(this.currentRadicalView != null){
        this.currentRadicalView.close();
        this.currentRadicalView = null;
      }
      var model = this.getModelNextRadical(this.positionRadical);
      this.currentRadicalView = this.initRadicalView(model);
      $('.js-input').focus();
    },

    initRadicalView: function(model){
      if(_.isUndefined(model)){
        if(this.isReview){
          location.reload();
          return;
        }
        model = this.collection.first();
        this.positionRadical = 0;
      }

      var radicalView = new JP.Views.ShowRadicalView({
        model: model
      });

      this.$('.js-radical-wrap').append(radicalView.render().el);


      return radicalView;
    },

    getModelNextRadical: function(position){
      return this.collection.at(position);
    },

    onClose: function() {
      this.unbindEvents();
    }

  });

});
