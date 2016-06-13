// models/question.js
import DS from "ember-data"; 

export default DS.Model.extend({
  answers: DS.hasMany("answer", {async:true}),
  id: DS.attr(),
  text: DS.attr(),
  type: DS.attr(),

});