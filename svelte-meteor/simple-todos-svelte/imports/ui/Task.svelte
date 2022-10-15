<script>
  export let task;

  // toggle onClick: flips task's isChecked
  const toggleChecked = () =>
    Meteor.call('tasks.setIsChecked', task._id, !task.isChecked);

  // delete onClick: deletes task from database
  const deleteThisTask = () => Meteor.call('tasks.remove', task._id);
</script>

<!-- Creates a task component -->
<li>
    <!-- checkbox item: onClick toggle's a todo's isChecked component -->
    <input
        type="checkbox"
        readonly
        checked={!!task.isChecked}
        on:click={toggleChecked}
    />
    <!-- task label -->
    <span>{ task.text }</span>
    <!-- task delete button: with deleteThisTask as an onclick -->
    <button class="delete" on:click={deleteThisTask}>&times;</button>
</li>
