import DS from 'ember-data';
import ScoreboardAdapter from 'scoreboardgui/adapters/scoreboard'

var ApplicationAdapter = ScoreboardAdapter.extend({
  namespace: '',
  host: 'http://localhost:3000'
});

export default ApplicationAdapter;