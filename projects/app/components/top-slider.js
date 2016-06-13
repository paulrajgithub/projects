import Ember from 'ember';


export default Ember.Component.extend({
  authenticator: 'simple-auth-authenticator:devise',

  session: Ember.inject.service('session'),

  actions:{
  	invalidateSession: function() {
	    this.get('session').invalidate();
	},
    authenticate: function() {
      let { identification, password } = this.getProperties('identification', 'password');
      return this.get('session').authenticate('authenticator:devise', identification, password).catch((reason) => {
        this.set('errorMessage', reason.error || reason);
      });
    }
  }	
});
