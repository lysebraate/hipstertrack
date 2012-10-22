(function() {

  var User = Backbone.Model.extend({
    urlRoot: "/users"
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
      var template = _.template($("#user_template").html(), this.model.attributes);
      this.$el.html(template); 
    }
  });

  var AddUserView = Backbone.View.extend({
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
    },
    events: {
      "submit form": "toggleSubscribe"
    },
    toggleSubscribe: function(event){
      alert("HAHAHA");
      console.log("toggling subscribe");
      return false;
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

  var Subscription = Backbone.Model.extend({});

  var Subscriptions = Backbone.Collection.extend({
    model: Subscription,
    initialize: function(user){
      this.url = "/users/" + user.userid + "/subscriptions"
    }
  });

  var LegeRouter = Backbone.Router.extend({
    routes: {
      "users": "showUsers",
      "users/:id": "showUser"
    },
    
    showUsers: function(){
      var userView = new AddUserView({el: $("#add_user")});
      var users = new Users();
      users.fetch({success: function(){
        var userListView = new UserListView({el: $("#user_list"), collection: users});
      }});
    },
    showUser: function(userId){
      var leger = new Leger();
/*      leger.fetch({success: function(){
        var legerView = new LegerView({el: $("#leger"), collection: leger});
      }});*/

      var newUser = new User({id: userId});
      newUser.fetch({success: function(){
        console.log(newUser);
        var userView = new UserView({el: $("#user"), model: newUser});
      }});
    }
  });

  $(document).ready(function(){
    var legeRouter = new LegeRouter();
    Backbone.history.start();
    legeRouter.navigate('#users');

    var subscriptions = new Subscriptions({userid:"507c70950240e6280f000001"});

    subscriptions.fetch({success: function(){
      console.log("Fetching shit...");
    }});

//    subscriptions.create({userid:"507c70950240e6280f000001",doctorid:"123456"});

  });
}());
