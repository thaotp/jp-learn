/*
 * Bootstrapping the main Fountain Greetings application.
 */
$(function() {

  var JPolary = function() {
    this.initialize.apply(this, arguments);
  };

  JPolary.prototype = {

    initialize: function() {
      var _this = this;

      JP.events.listenToOnce(JP.events, 'appLoaded', function() {

        // var pusher = new Pusher(JP.pusherKey, {
        //   encrypted: true
        // });
        // JP.channel = pusher.subscribe('JP');
        // create a model for managing some global states
        JP.state = new (Backbone.Model.extend({}))();

        // Initialize the router and start the Backbone app
        JP.router = new JP.Router();

        // run the initialize method to bootstrap the app, then start backbone history
        _this.bootstrap(function(done) {
          // start backbone pushstate
          Backbone.history.start({ pushState: true });
          JP.events.trigger('bootstrap:done');
        });
      });
    },

    bootstrap: function(done) {
      done();
      return true
    }
  };

  new JPolary();


});