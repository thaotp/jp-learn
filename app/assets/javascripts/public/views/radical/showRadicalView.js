/*
 * Main view for the JP home page
 * URI: /
 */
$(function() {

  'use strict';

  JP.Views.ShowRadicalView = Backbone.View.extend({

    events: {
      'keydown .js-input': 'enterInput'
    },

    tagName: 'article',

    template: JP.Templates['public/templates/radical/show'],

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
      context.radical = this.model.toJSON();
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
        if($(e.currentTarget).val() == this.model.get('china').toLowerCase()){
          this.$('.js-times').html(+times + 1)
          this.model.set('times', + times + 1)
          $(e.currentTarget).val('')
        }else{
          this.$('.js-input').addClass('animated shake')
        }
        if(times >= JP.Times){
          var req = this.model.save();
          req.done(function(e) {
            JP.events.trigger('next:radical');
          });
        }
      }
    },

    onClose: function() {
      this.remove();
      this.unbindEvents();
    }

  });

});
