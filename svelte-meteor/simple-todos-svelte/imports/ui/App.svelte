<script>
  // imports the db  
  import { TasksCollection } from '../db/TasksCollection';
  import { Meteor } from 'meteor/meteor';
  // imports a task component
  import Task from './Task.svelte';
  // imports taskform component to input tasks
  import TaskForm from './TaskForm.svelte';
  // imports the login form component to login
  import LoginForm from './LoginForm.svelte';

  // current filter (whether we are hiding the completed tasks or not)
  let hideCompleted = false;

  // if we are hiding completed, do not show tasks with isChecked on
  const hideCompletedFilter = { isChecked: { $ne: true } };


  // puts number of pending tasks in the app bar
  let incompleteCount;
  let pendingTasksTitle = '';
  // todo list
  let tasks = [];
  // current user
  let user = null;
  // whether we are loading from DB
  let isLoading = true;

  const handler = Meteor.subscribe('tasks');
  $m: {
    user = Meteor.user();

    if (user) {

        isLoading = !handler.ready();

        // this conducts a mini MongoDB query for only searching for current todo filter
        const userFilter = { userId: user._id };
        const pendingOnlyFilter = { ...hideCompletedFilter, ...userFilter };

        // retrieve tasks from the database (sorts by newest tasks first)
        tasks = TasksCollection.find(
                hideCompleted ? pendingOnlyFilter : userFilter,
                { sort: { createdAt: -1 } }
            ).fetch();
        
        // counts number of pending tasks
        incompleteCount = TasksCollection.find(pendingOnlyFilter).count();

        // puts number of pending tasks in app bar
        pendingTasksTitle = `${
          incompleteCount ? ` (${incompleteCount})` : ''
        }`;
    }
  }

  // sets filter
  const setHideCompleted = value => {
    hideCompleted = value;
  };

  // logs out of our app (removes current user session)
  const logout = () => Meteor.logout();
</script>

<!-- overall app body -->
<div class="app">
    <!-- app heading -->
    <header>
        <div class="app-bar">
            <div class="app-header">
                <!-- app title -->
                <h1>📝️ To Do List {pendingTasksTitle}</h1>
            </div>
        </div>
    </header>

    <div class="main">
        <!-- only show todos if the user is logged in -->
        {#if user}
            <div class="user" on:click={logout}>
                {user.username} 🚪
            </div>

            <!-- form to input tasks -->
            <TaskForm />

            <!-- filter button -->
            <div class="filter">
                <!-- sets the current filter when clicked: alternates between showing all todos, or hiding completed -->
                <button on:click={() => setHideCompleted(!hideCompleted)}>
                    {hideCompleted ? 'Show All' : 'Hide Completed'}
                </button>
            </div>

            <!-- has a loading screen as we connect to the database -->
            {#if isLoading}
                <div class="loading">loading...</div>
            {/if}

            <!-- iterate through each task in the database collection -->
            <ul class="tasks">
              {#each tasks as task (task._id)}
                  <Task task={task} />
              {/each}
            </ul>
        {:else}
            <!-- if user is not logged in, show login form -->
            <LoginForm />
        {/if}
    </div>
</div>
