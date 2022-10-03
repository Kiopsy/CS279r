<!-- Javascript for our Svelte app -->
<script>
  // import stylesheet
  import './index.css';

  //import onMount
  import { onMount } from 'svelte';

  // import firebase commands
  import { initializeApp, getApps, getApp } from "firebase/app";
  import {
    getFirestore,
    collection,
    onSnapshot,
    doc,
    addDoc,
    updateDoc,
    deleteDoc,
  } from "firebase/firestore";
  import { firebaseConfig } from "$lib/firebaseConfig";
  import { browser } from "$app/env";

  // initialize our firebase app
  const firebaseApp =
    browser &&
    (getApps().length === 0 ? initializeApp(firebaseConfig) : getApp());

  // initalize our database (Firebase's Firestore)
  const db = browser && getFirestore();

  // access the collection within our database
  const colRef = browser && collection(db, "todos");

  // list of todos
  let todos = [];

  // get the list of todos from the collection
  const unsubscribe =
    browser &&
    onSnapshot(colRef, (querySnapshot) => {
      let fbTodos = [];
      querySnapshot.forEach((doc) => {
        let todo = { ...doc.data(), id: doc.id };
        fbTodos = [todo, ...fbTodos];
      });
      todos = fbTodos;
    });


  // task & error strings
  let task = "";
  let error = "";

  // function to add todos
  const addTodo = async () => {
    // only add non-empty tasks
    if (task !== "") {
      // a todo's attributes to put into the database
      const docRef = await addDoc(collection(db, "todos"), {
        task: task,
        isComplete: false,
        createdAt: new Date(),
      });
      error = "";
    } else {
      error = "Task is empty";
    }
    // reset the form input
    task = "";
  };

  // mark a todo as complete
  const markTodoAsComplete = async (item) => {
    await updateDoc(doc(db, "todos", item.id), {
      isComplete: !item.isComplete,
    });
  };

  // delete a todo
  const deleteTodo = async (id) => {
    await deleteDoc(doc(db, "todos", id));
  };

  // check if the spacebar was pressed in order to add a todo
  const keyIsPressed = (event) => {
    if (event.key === "Enter") {
      addTodo();
    }
  };

  // input field element reference
  let ref = null;

  onMount(() => {
    // focus the input field on app load
    ref.focus();
  });

</script>

<!-- HTML for our Svelte app -->
<section class="todoapp">

  <!-- heading title -->
  <header class="header">
    <h1>todos</h1>
      <!-- input form for todo -->
      <input
        class="new-todo"
        type="text"
        bind:value={task}
        bind:this={ref}
        placeholder="What needs to be done?"
      />
  </header>

  <!-- ordered list for todos -->
  <ol>
    <!-- iterate through all the todos -->
    {#each todos as item}
      <li class:complete={item.isComplete}>
        <!-- display the todo's task label -->
        <span>
          {item.task}
        </span>
        <span>
          <!-- add onclick listeners to each todo in other to complete/delete them -->
          <button on:click={() => markTodoAsComplete(item)}>✔</button>
          <button on:click={() => deleteTodo(item.id)}>✘</button>
        </span>
      </li>
    <!-- raise an error if no todos are found in the database -->
    {:else}
      <p>No todos found</p>
    {/each}
    <p class="error">{error}</p>
  </ol>
  
  <!-- add a footer just for the css: stacked page effect -->
  <footer class="footer"></footer>
</section>

<!-- listen for keys pressed -->
<svelte:window on:keydown={keyIsPressed} />
