import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_ml/consts.dart';
import 'screens/home_page.dart'; // Import InitialScreen

void main() {
  Gemini.init(apiKey: GEMINI_API_KEY);
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
      home: HomePage(), // Set InitialScreen as the initial screen
    );
  }
}
