import DS from 'ember-data';

export default DS.Model.extend({
  firstname: DS.attr('string'),
  lastname: DS.attr('string'),
  email: DS.attr('string'),
  password: DS.attr('string'),
  dateofbirth: DS.attr(),
});
