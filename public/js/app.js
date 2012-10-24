(function() {

  var User = Backbone.Model.extend({
    urlRoot: "/users"
  });

  var Users = Backbone.Collection.extend({
    model: User,
    url: "/users"
  });

  var Lege = Backbone.Model.extend({    
  });

  var Leger = Backbone.Collection.extend({
    model: Lege,
    url: "/doctors"
  });

  var Subscription = Backbone.Model.extend({
    initialize: function(options){
      this.url = "/users/" + options.userid + "/subscriptions/" + options.doctorid;
    },
  });

  var Subscriptions = Backbone.Collection.extend({
    initialize: function(options){
      this.url = "/users/" + options.userid + "/subscriptions";
     },
    model: Subscription
  });

  var UserView = Backbone.View.extend({
    initialize: function(options){
      var that = this;
	    options.router.on('route:showUser', function(userId) {
        that.fetchUser(userId);
	    });
      options.router.on('route:showUsers', function(){
        $(that.el).hide();
      });
    },
    render: function(){
      var that = this;
      var template = _.template($("#user_template").html(), this.model.attributes);
      this.$el.append(template);
      var follows = $("#follows", this.$el);
      var leger = new Leger();
      leger.fetch({success: function(){
        var legerView = new LegerView({collection: leger, el: follows});
        legerView.render(that.model.get("id"));
      }});
      this.$el.show();
    },
    fetchUser: function(userId){
      var that = this;
      var user = new User({id: userId});
      user.fetch({success: function(){
        that.model = user;
        that.render();
      }});
    }
  });

  var AddUserView = Backbone.View.extend({
    initialize: function(){
      this.render();
    },
    render: function(){
      var template = _.template($("#add_user_template").html(), {});
      this.$el.html(template); 
      this.$el.show();
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
    initialize: function(options){
      var that = this;
      options.router.on('route:showUsers', function(){
        that.fetchUsers();
      });
      options.router.on('route:showUser', function(userId){
        $(that.el).hide();
      });

    },
    render: function(){
      var that = this;
      this.collection.each(function(user){
        that.$el.append('<li><a href="#users/' + user.get("id") + '">' + user.get("firstname") + " " + user.get("lastname") + "</a></li>");
      });
    },
    fetchUsers: function(){
      var that = this;
      var users = new Users();
      users.fetch({success: function(){
        that.collection = users;
        that.render();
      }});
    }
  });


  var LegeView = Backbone.View.extend({
    initialize: function(){
      this.render();
    },
    render: function(){
      var template = _.template($("#doctorlist_item_template").html(), this.model.attributes);
      this.$el.append(template);
      var submitButton = $("button", this.$el);
      submitButton.attr("id", this.model.get("id")); 
      if(this.model.attributes.followed){
        submitButton.attr("class", "btn btn-danger");
        submitButton.empty();
        submitButton.append("Slutt å følge");
      } else {
        submitButton.attr("class", "btn btn-success");
      }
    },
    events: {
      "click .btn": "toggleSubscribe"
    },
    toggleSubscribe: function(event){
      this.$el.trigger('toggled', this.model); 
    }
  });

  var LegerView = Backbone.View.extend({
    initialize: function() {
    },
    events: {
      "toggled": "toggleSubscribe"
    },
    tagName: "table",
    render: function(userId){
      var that = this;
      that.userId = userId;
      var template = _.template($("#doctors_template").html());
      this.$el.html(template);
      var tableBody = $("tbody", this.$el);

      that.subscriptions = new Subscriptions({userid: userId});
      that.subscriptions.fetch({success: function(){
        var followedDoctors = _.map(that.subscriptions.models, function(subscription) { return subscription.get("doctorid"); });
        that.collection.each(function(lege){
          var isFollowed = _.contains(followedDoctors, lege.id + "");
          var subscription = _.find(that.subscriptions.models, function(subscription) { return subscription.get("doctorid") === (lege.id + ""); });
          lege.set({followed: isFollowed});
          lege.set({subscription: subscription});
          var tableRow = $("<tr>").appendTo(tableBody);
          var legeView = new LegeView({model: lege, el: tableRow});
        });  
      }});
    },
    toggleSubscribe: function(event, data){
      var that = this;
      var subscription = data.get("subscription");
      if(subscription === undefined){
        var doctorId = data.get("id");
        var newSubscription = new Subscription({userid: this.userId, doctorid: doctorId});
        newSubscription.save();
      } else {
        subscription.destroy();
        //this.subscriptions.remove(subscription);
      }
      that.render(that.userId);

      event.preventDefault();
    }
  });

  var LegeRouter = Backbone.Router.extend({
    routes: {
      "users": "showUsers",
      "users/:id": "showUser"
    }
  });

  $(document).ready(function(){
    var legeRouter = new LegeRouter();

    var userListView = new UserListView({el: $("#user_list"), router: legeRouter});
    var userView = new UserView({el: $("#user"), router: legeRouter});
    var addUserView = new AddUserView({el: $("#add_user")});

    Backbone.history.start();
  });
}());
