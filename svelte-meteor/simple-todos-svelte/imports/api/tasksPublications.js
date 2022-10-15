import { Meteor } from 'meteor/meteor';
import { TasksCollection } from '/imports/db/TasksCollection';

// finds user that can publish tasks to ensure correct users get correct todos
Meteor.publish('tasks', function publishTasks() {
  return TasksCollection.find({ userId: this.userId });
});
