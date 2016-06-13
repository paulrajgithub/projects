// models/templateheader.js
import DS from "ember-data"; 

var Templateheader =  DS.Model.extend({
  id: DS.attr(),
  title: DS.attr('string'),
  name: DS.attr(),
  columns: DS.attr(),
  logo: DS.attr(),
});
Templateheader.reopenClass({
   FIXTURES: [
     {id: 1, title: 'Rendezvous', name: 'Rendezvous', columns: 4, logo: 4},
   ]
 });