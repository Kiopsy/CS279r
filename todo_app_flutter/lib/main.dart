import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home.dart';

// Main function
void main() {
  runApp(const MyApp());
}

// Root application class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        // Changes status bar to be transparent
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Sets app title
      title: 'ToDo App',
      // Build's home widget/state
      home: Home(),
    );
  }
}
