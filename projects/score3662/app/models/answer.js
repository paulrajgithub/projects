// models/answer.js
import DS from "ember-data"; 

export default DS.Model.extend({
  id: DS.hasMany("answer", {async:true}),
  text: DS.attr(),
  checked: DS.attr(),
  selected: DS.attr(),

});