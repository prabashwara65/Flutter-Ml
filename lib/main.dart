import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_ml/consts.dart';
// import 'screens/home_page.dart'; // Import InitialScreen
import 'package:flutter_ml/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'AIzaSyDYOea7XynI24gb9fZSOR_XHDzTVzSIj6w',
    appId: 'ml-app-5f335',
    messagingSenderId: 'sendid',
    projectId: 'ml-app-5f335',
  )
);
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
      home: WidgetTree(), // Set InitialScreen as the initial screen
    );
  }
}
