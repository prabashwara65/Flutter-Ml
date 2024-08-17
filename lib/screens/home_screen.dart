import 'package:flutter/material.dart';
import 'package:flutter_ml/screens/scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Scanner')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScannerScreen()),
            );
          },
          child: Text('Scan Text'),
        ),
      ),
    );
  }
}
