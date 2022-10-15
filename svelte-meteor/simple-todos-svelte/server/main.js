// imports meteor functions
import { Meteor } from 'meteor/meteor';
// imports the 
import { Accounts } from 'meteor/accounts-base';
// imports the database
import { TasksCollection } from '/imports/db/TasksCollection';
import '/imports/api/tasksMethods';
import '/imports/api/tasksPublications';

// function to insert a task with text taskText inside the database
// under a specific user's account
const insertTask = (taskText, user) =>
  TasksCollection.insert({
    text: taskText,
    userId: user._id,
    createdAt: new Date(),
  });

// the set username/password in order to open our app. 
const SEED_USERNAME = 'meteorite';
const SEED_PASSWORD = 'password';

// on startup of the application
Meteor.startup(() => {
  // if user does not exist, create user
  if (!Accounts.findUserByUsername(SEED_USERNAME)) {
    Accounts.createUser({
      username: SEED_USERNAME,
      password: SEED_PASSWORD,
    });
  }

  // set the global user
  const user = Accounts.findUserByUsername(SEED_USERNAME);

  // Sets sample tasks to our collection (db) if the database is empty
  if (TasksCollection.find().count() === 0) {
    [
      'First Task',
      'Second Task',
      'Third Task',
      'Fourth Task',
      'Fifth Task',
      'Sixth Task',
      'Seventh Task',
    ].forEach(taskText => insertTask(taskText, user));
  }
});
