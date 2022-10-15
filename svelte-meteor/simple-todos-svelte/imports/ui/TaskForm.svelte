<script>
    export let user = null;
    // newTask is the text value of the todo
    let newTask = '';

    // on submit button onClick
    const handleSubmit = () => {
      // if no text, do not input a todo
      if (!newTask) return;

      // insert newTask into the database
      Meteor.call('tasks.insert', newTask);

      // Clear form
      newTask = '';
    }
</script>

<!-- actual form HTML for task (TaskForm component) -->
<form class="task-form" on:submit|preventDefault={handleSubmit}>
    <!-- takes in just a text value -->
    <input
            type="text"
            name="text"
            placeholder="Type to add new tasks"
            bind:value={newTask}
    />
    <!-- submit button -->
    <button type="submit">Add Task</button>
</form>
