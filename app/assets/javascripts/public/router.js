/*
 *
 */
/*
 * Backbone Router for JP.
 * This file should be loaded last in application.js so Backbone.history.start()
 * can properly setup and trigger the corresponding view.
 */

$(function() {

  'use strict';

  JP.Router = Backbone.Router.extend({

    routes: {
      // home
      '': 'homeRoute',
      '/': 'homeRoute',
      'word': 'wordRoute',
      'word/': 'wordRoute',
      'radical': 'radicalsRoute',
      'radical/': 'radicalsRoute',
    },

    initialize: function() {
      var _this = this;

      this.listenTo(this, 'route', function (route, params) {
        routeStore.push(Backbone.history.fragment);
      });

      this.listenTo(JP.state, 'change:loading', function() {
        console.log(88)
        if (JP.state.get('loading')) {

        } else {

        }
      });
      this.htmlClasses = $('html').attr('class');
    },

    // Called before the route function
    before: function(route) {
      // clean up old view)
      if (typeof this.currentView !== 'undefined') {
        this.currentView.close();
        delete this.currentView;
      }
      JP.state.set('loading', true)
      console.log(77)
      $('html').attr('class', this.htmlClasses);
    },

    // Called after the route function
    after: function(route) {

    },

    authenticate: function() {
      // Authenticate is called after 'before' and if it returns false, the callstack ends.
      return true;
    },

    authorize: function() {
      var authorized = true,
          _this = this;

      return authorized;
    },

    errorRoute: function(errorPage) {
      errorPage = errorPage ? errorPage : '404';
      this.currentView = new JP.Views.ErrorView({
        errorPage: errorPage
      });
    },

    homeRoute: function() {
      this.currentView = new JP.Views.HomeView();
    },

    wordRoute: function() {
      this.currentView = new JP.Views.WordView();
    },

    radicalsRoute: function() {
      this.currentView = new JP.Views.IndexRadicalView();
    },
  });

});
