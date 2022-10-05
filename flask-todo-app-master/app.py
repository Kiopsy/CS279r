import os
from re import A
from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

PROJECT_ROOT = os.path.dirname(os.path.realpath(__file__))
DATABASE = os.path.join(PROJECT_ROOT, 'todo.db')

# connecting to the database
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///todo.db"
db = SQLAlchemy(app)

# boolean if next page reload needs to have confetti
confettiUpdate = False

# creating a todo model for the database
class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80))
    complete = db.Column(db.Boolean)

# home page
@app.route("/")
def index():
    # queries all todos in the database
    todo_list = Todo.query.all()

    # uses the global variable confettiUpdate
    global confettiUpdate

    # renders page depending on if confetti needs to be shown (if use completes a todo)
    confettiTmp = False
    if confettiUpdate:
        confettiTmp = True
        confettiUpdate = False

    # renders homepage
    return render_template("index.html", todo_list=todo_list, confettiUpdate=confettiTmp)

# route for adding a todo
@app.route("/add", methods=["POST"])
def add():
    # gets todo label
    title = request.form.get("title")

    # creates a todo using Todo Model
    new_todo = Todo(title=title, complete=False)

    # pushes new todo to database
    db.session.add(new_todo)
    db.session.commit()

    # renders home page
    return redirect(url_for("index"))

# update route
@app.route("/complete/<string:todo_id>")
def complete(todo_id):
    # queries for the todo that needs to be updated
    todo = Todo.query.filter_by(id=todo_id).first()

    # sets it's complete variable to opposite of its current
    todo.complete = not todo.complete

    # sets global variable for confetti if a user completed a todo
    global confettiUpdate
    if todo.complete:
        confettiUpdate = True

    # push changes to database
    db.session.commit()

    # render home page
    return redirect(url_for("index"))

# route for deleting a todo
@app.route("/delete/<string:todo_id>")
def delete(todo_id):
    # queries for todo to delet
    todo = Todo.query.filter_by(id=todo_id).first()

    # delete todo and push changes to db
    db.session.delete(todo)
    db.session.commit()

    # render home page
    return redirect(url_for("index"))

# creates database and runs the app
if __name__ == "__main__":
    db.create_all()
    app.run(debug=True)
