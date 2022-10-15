// meteor is awesome as it automatically sets up MongoDB for us to
// use as our database!
import { Mongo } from 'meteor/mongo';

// creates a new collection (db) for tasks using MongoDB
export const TasksCollection = new Mongo.Collection('tasks');
