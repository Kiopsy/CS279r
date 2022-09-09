const express = require('express'); // start the server
const app = express(); // start the server
const dotenv = require("dotenv"); // allows .env file access
const mongoose = require("mongoose"); // Mongoose to provide schema-based model for application data.
const TodoTask = require("./models/TodoTask"); // schema model

// configure .env for password extraction
dotenv.config();

app.use("/static", express.static("public"));
app.use(express.urlencoded({ extended: true }));

//connection to db
mongoose.connect(process.env.DB_CONNECT, {}, () => {
    console.log("Connected to db!");
    app.listen(3000, () => console.log("Server Up and running"));
});

// view engine configuration
app.set("view engine", "ejs");

// GET METHOD
app.get("/", (req, res) => {
    // renders all tasks in db
    TodoTask.find({}, (err, tasks) => {
        res.render("todo.ejs", { todoTasks: tasks });
    });
});

//POST METHOD
app.post('/',async (req, res) => {
    // Retrieve content from text input
    const todoTask = new TodoTask({
        content: req.body.content
    });

    // Try posting to db
    try {
        await todoTask.save();
        console.log("Posted to db!");
        res.redirect("/");
    } catch (err) {
        console.log("db error: " + err);
        res.redirect("/");
    }
});

//UPDATE METHOD
app.route("/edit/:id")
    // gets desired task & id for update
    .get((req, res) => {
        const id = req.params.id;
        TodoTask.find({}, (err, tasks) => {
            res.render("todoEdit.ejs", { todoTasks: tasks, idTask: id });
            });
        })
    // updates the task in db
    .post((req, res) => {
        const id = req.params.id;
        TodoTask.findByIdAndUpdate(id, { content: req.body.content }, err => {
        if (err) return res.send(500, err);
        res.redirect("/");
        });
    });

//DELETE METHOD
app.route("/remove/:id").get((req, res) => {
    // Retreive object id of task
    const id = req.params.id;

    // Delete from db
    TodoTask.findByIdAndRemove(id, err => {
        if (err) return res.send(500, err);
        res.redirect("/");
    });
});