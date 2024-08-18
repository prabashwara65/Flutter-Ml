import 'package:flutter/material.dart';
import 'screens/initial_screen.dart'; // Import InitialScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: InitialScreen(), // Set InitialScreen as the initial screen
    );
  }
}
