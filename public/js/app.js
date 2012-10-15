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
      this.collection.each(function(user){
        that.$el.append('<li><a href="#users/' + user.get("id") + '">' + user.get("firstname") + " " + user.get("lastname") + "</a></li>");
      });
    }
  });

  var Lege = Backbone.Model.extend({    
  });

  var Leger = Backbone.Collection.extend({
    model: Lege,
    url: "/doctors"
  });

  var LegeView = Backbone.View.extend({
    initialize: function(){
      this.render();
    },
    render: function(){
      var template = _.template($("#doctorlist_item_template").html());
      this.$el.html(template(this.model.attributes));
    }
  });

  var LegerView = Backbone.View.extend({
    initialize: function() {
      this.render();
    },
    render: function(){
      var template = _.template($("#doctors_template").html());
      this.$el.html(template);
      var tableBody = $("tbody", this.$el);
      this.collection.each(function(lege){
        var legeView = new LegeView({model: lege});
        tableBody.append(legeView.$el.html());
    });  
    }
  });

  var LegeRouter = Backbone.Router.extend({
    routes: {
      "users": "showUsers",
      "users/:id": "showUser"
    },
    
    showUsers: function(){
      var userView = new UserView({el: $("#add_user")});
      var users = new Users();
      users.fetch({success: function(){
        var userListView = new UserListView({el: $("#user_list"), collection: users});
      }});
    },
    showUser: function(userId){
      var leger = new Leger();
      leger.fetch({success: function(){
        var legerView = new LegerView({el: $("#leger"), collection: leger});
      }});
    }
  });

  $(document).ready(function(){
    var legeRouter = new LegeRouter();
    Backbone.history.start();
    legeRouter.navigate('#users');
  });
}());
