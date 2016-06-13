// models/profilepage.js
import DS from "ember-data"; 

var Profilepage = DS.Model.extend({
  components: DS.hasMany("component", {async:true}),
  suggestedusers: DS.hasMany("user", {async:true}),
  id: DS.attr(),
  user:DS.attr(),
});

Profilepage.reopenClass({
   FIXTURES: [
     {id: 1, firstName: 'Bugs', lastName: 'Bunny', email: 'adet4ever@hotmail.com'},
     {id: 2, firstName: 'Wile E.', lastName: 'Coyote', email: 'adet4ever@hotmail.com'}
   ]
 });