// Class Representing a To-Do Object
class ToDo {
  // Id of a to-do
  String? id;
  // Text of a to-do
  String? todoText;
  // Done attribute crosses off a to-do
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    // Initially sets the To-Do object to not done
    this.isDone = false,
  });

  // To-Do list to display on application
  static List<ToDo> todoList() {
    return [
      // Can pre-set to-do list here:
      ToDo(id: '01', todoText: 'Morning Excercise', isDone: true ),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true ),
      ToDo(id: '03', todoText: 'Check Emails', ),
      ToDo(id: '04', todoText: 'Team Meeting', ),
      ToDo(id: '05', todoText: 'Work on mobile apps for 2 hour', ),
      ToDo(id: '06', todoText: 'Dinner with Jenny', ),
    ];
  }
}