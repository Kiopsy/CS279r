# Flask Todo App

Simple Flask Todo App using SQLAlchemy and SQLite database.

For most of this assignment, the code is based off the [source code](https://www.youtube.com/playlist?list=PLm_Qt4aKpfKiGbdjaHdOpry6Neza0etxZ). For extensions, I changed the UI, and added this cool stacked pages effect on the todo container itself. Furthermore, I added confetti that runs over the screen only when a user completes a todo.   

## Differences from previous frameworks
Flask is a very interesting framework in the sense that it works similar to Svelte and Node.js by allowing us to put flask code in HTMLs and pass in variables upon rendering a template. It is super easy to use since it uses Python (which is different than any other framework we have used), but also pairs well with HTML and Javascript (allowing me to easily add a confetti script for example). Also, Flask pairs really well with SQL or SQLite which makes it easy to get a simple database up and running. However, running the SQL script at first can be a little difficult to use. 

### Setup Instructions
Create project with virtual environment

In the folder: flask-todo-master

$ python3 -m venv venv
Activate it

$ . venv/bin/activate
or on Windows

venv\Scripts\activate
Install Flask

$ pip install Flask
$ pip install Flask-SQLAlchemy
Set environment variables in terminal

$ export FLASK_APP=app.py
$ export FLASK_ENV=development
or on Windows

$ set FLASK_APP=app.py
$ set FLASK_ENV=development
Run the app

$ flask run

Load the http:// link it displays in your browser to run the app. 