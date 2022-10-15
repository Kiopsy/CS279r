import { Meteor } from 'meteor/meteor';
import App from '../imports/ui/App.svelte';

// creates new app on startup
Meteor.startup(() => {
  new App({
    target: document.getElementById('app'),
  });
});
