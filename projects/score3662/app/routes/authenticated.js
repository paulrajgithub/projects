import Score366Route from 'scoreboardgui/routes/score366';
import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

var AuthenticatedRoute = Score366Route.extend(AuthenticatedRouteMixin,{

});

export default AuthenticatedRoute;