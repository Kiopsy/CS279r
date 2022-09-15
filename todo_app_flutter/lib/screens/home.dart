import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// HomeState of application
class _HomeState extends State<Home> {
  // To-do List to display
  final todosList = ToDo.todoList();
  // Holds results for search
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    // Initializes to-do list
    _foundToDo = todosList;
    super.initState();
  }

  // Application's home widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sets application background color
      backgroundColor: tdBGColor,
      // Builds custom app bar using _buildAppBar() below
      appBar: _buildAppBar(),
      // Horizontal stack widget
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            margin: const EdgeInsets.only(
              bottom: 60
            ),
            child: Column(
              children: [
                // Searchbox widget at the top
                // searchBox(),
                Expanded(
                  // ListView widget to hold to-do items
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        // Title to-do text
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),
                        ),
                      ),
                      // Adds each to-do object in to-do list to ListView
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Floating container for adding To-do items
          Align(
            // At bottom-center of the screen
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  // Adds a shadow to the to-do list adder container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // TextField for adding to-do items
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              // Container for adding to-do items
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  // Adding to-do item function
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  // Button for adding to-do items
                  style: ElevatedButton.styleFrom(
                    primary: tdYellow,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // handle's to-do on click
  void _handleToDoChange(ToDo todo) {
    setState(() {
      // Flips to-do item's isDone state
      todo.isDone = !todo.isDone;
    });
  }

  // Removes to-do item from to-do list
  void _deleteToDoItem(String id) {
    setState(() {
      // Removes from the list by searching id
      todosList.removeWhere((item) => item.id == id);
    });
  }

  // Add's to-do item to to-do list
  void _addToDoItem(String toDo) {
    // Ensure the inputted toDo is not empty
    if (toDo.isNotEmpty){
      setState(() {
        todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ));
      });
      _todoController.clear();
    } 
  }

  // Search filter's algorithm
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      // Searches through entire to-do list text for 'enteredKeyword'
      results = todosList
          .where((item) => item.todoText!
              // ignores case to search
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // sets list to display results
    setState(() {
      _foundToDo = results;
    });
  }

  // SearchBox Widget
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 15,
        right: 15,
      ),
      // SearchBox Color & Rounded corners
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // TextField
      child: TextField(
        // onChanged function: uses _runFilter
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          // Search icon 
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          // Textfield constraints
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          // Text hint
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  // Application's custom App Bar w/ menu button & profile image
  AppBar _buildAppBar() {
    return AppBar(
      // set's background color from constants
      toolbarHeight: 75,
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Search bar within App Bar
        Expanded(child: searchBox()),
        // Profile image container
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // loads profile image (image in assets folder)
            child: Image.asset('assets/images/victor.jpg'),
          ),
        ),
      ]),
    );
  }
}