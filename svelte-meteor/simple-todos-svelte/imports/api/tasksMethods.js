import { Meteor } from 'meteor/meteor';
import { check } from 'meteor/check';
import { TasksCollection } from '../db/TasksCollection';

// define the meteor methods to use between files
Meteor.methods({
  // insert method: takes text and creates a todo and inserts into db
  'tasks.insert'(text) {
    check(text, String);

    if (!this.userId) {
      throw new Meteor.Error('Not authorized.');
    }

    // inserts todo, createdAt, and user with todo into db
    TasksCollection.insert({
      text,
      createdAt: new Date(),
      userId: this.userId,
    });
  },

  // remove method: if todo is in user's db, delete it from their connection. 
  'tasks.remove'(taskId) {
    check(taskId, String);

    // check for authentication
    if (!this.userId) {
      throw new Meteor.Error('Not authorized.');
    }

    // find todo to delete
    const task = TasksCollection.findOne({ _id: taskId, userId: this.userId });

    if (!task) {
      throw new Meteor.Error('Access denied.');
    }

    TasksCollection.remove(taskId);
  },

  // toggles isChecked in db
  'tasks.setIsChecked'(taskId, isChecked) {
    check(taskId, String);
    check(isChecked, Boolean);

    // ensure authentication
    if (!this.userId) {
      throw new Meteor.Error('Not authorized.');
    }

    // find todo in db
    const task = TasksCollection.findOne({ _id: taskId, userId: this.userId });

    if (!task) {
      throw new Meteor.Error('Access denied.');
    }

    // updates todo in db
    TasksCollection.update(taskId, {
      $set: {
        isChecked,
      },
    });
  },
});
