import Score366Route from 'score366/routes/score366';
import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

var AuthenticatedRoute = Score366Route.extend(AuthenticatedRouteMixin,{

});

export default AuthenticatedRoute;