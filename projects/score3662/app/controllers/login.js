import Ember from 'ember';
import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin';

export default Ember.Controller.extend(LoginControllerMixin, {
  authenticator: 'simple-auth-authenticator:devise',
  showsignup:false,
  showlogin:true,

  bplTable: function(){
    var x = 3;
    $.ajax({
      url: "http://live.premierleague.com/syndicationdata/competitionId=8/seasonId=2015/matchDayId=10/league-table.json?201512010130360361",
      type: "get",
    }).then(function(res) {
      var x = 3;
      return res;
    });
  }.property("showsignup"),

  actions: {
  	showSignup: function(){
  		var c = this;
  		var showsignup = c.get("showsignup");
  		c.set("showsignup", !showsignup);
 		c.set("showlogin", false);

  	},
  	showLogin: function(){
  		var c = this;
  		var showlogin = c.get("showlogin");
  		c.set("showlogin", !showlogin);
  		c.set("showsignup", false);
  	},
  	signup: function(){
  		var c = this;
 	 	var email = this.get("email");
 	 	var password = this.get("pw");
 	 	var confirmpw = this.get("confirmpw");
 	 	if(password !==confirmpw){
 	 		alert("Password does not match");
 	 	}else{
 	 		var user = c.store.createRecord("user", {
 	 			firstname: c.get("firstname"),
 	 			lastname: c.get("lastname"),
 	 			dateofbirth:c.get("dateofbirth"),
 	 			email: c.get('email'),
 	 			password:c.get("pw"),
 	 		});
 	 		user.save().then(function(user){
 	 			transitionToRoute("login");
 	 		});
 	 		// var url = localhost:3000/users/signup
 	 		// var variables = {email:email, password:password}
 	 		// $.ajax({
			  // url: searchurl,
     //          type: "post",
     //          data: variables,
     //        }).then(function(tickets) {
              
 	 	}
  	}
  }
});