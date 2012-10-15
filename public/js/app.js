(function() {

  var User = Backbone.Model.extend({
    url: "/users"
  });

  var UserView = Backbone.View.extend({
    initialize: function(){
      this.render();
    },
    render: function(){
      var template = _.template($("#add_user_template").html(), {});
      this.$el.html(template); 
    },
    events: {
      "click button[type=submit]": "addUser"
    },
    addUser: function(event){
      var newUser = new User({
        firstname: $("#firstname").val(),
        lastname: $("#lastname").val(),
        email: $("#email").val(),
        phone: $("#phonenumber").val()
      });
      newUser.save();
    }
  });

  $(document).ready(function(){
    var userView = new UserView({el: $("#add_user")});
  });
}());
