(function() {

  var User = Backbone.Model.extend({
    url: "/users"
  });

  var Users = Backbone.Collection.extend({
    model: User,
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

  var UserListView = Backbone.View.extend({
    initialize: function(){
      this.render();
    },
    render: function(){
      var that = this;
      _.each(this.collection.models, function(user){
        that.$el.append("<li>" + user.get("firstname") + " " + user.get("lastname") + "</li>");
      });
    }
  });

  $(document).ready(function(){
    var userView = new UserView({el: $("#add_user")});
    var users = new Users();
    users.fetch({success: function(){
      var userListView = new UserListView({el: $("#user_list"), collection: users});
    }});
  });
}());
