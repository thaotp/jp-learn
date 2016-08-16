/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.ShowWordView = Backbone.View.extend({

    events: {
      'keydown .js-input': 'enterInput'
    },

    tagName: 'article',

    template: JP.Templates['public/templates/word/show'],

    initialize: function() {

      this.listenToOnce(this, 'ready', _.bind(this.onReady, this));
      this.trigger('ready');
    },

    onReady: function() {
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
      this.$('.js-input').floatlabel({
        slideInput: false
      });
      return this;
    },

    enterInput: function(e){
      this.$('.js-input').removeClass('animated shake')
      var times = this.model.get('times')
      if(e.keyCode == 13){
        var value = $(e.currentTarget).val()
        if( value == this.model.get('name').replace(/～/g, '') || value == this.model.get('romanji')){
          this.$('.js-times').html(+times + 1)
          this.model.set('times', + times + 1)
          $(e.currentTarget).val('')
        }else{
          this.$('.js-input').addClass('animated shake')
        }
        if(times >= JP.Times){
          // var req = this.model.save();
          // req.done(function(e) {

          // });
          JP.events.trigger('next:word');
        }
      }
    },

    onClose: function() {
      this.remove();
      this.unbindEvents();
    }

  });

});
