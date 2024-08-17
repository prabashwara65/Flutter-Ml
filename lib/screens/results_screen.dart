import 'dart:io';

import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String extractedText;
  final String imagePath;

  ResultsScreen({required this.extractedText, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Results')),
      body: Column(
        children: [
          Image.file(File(imagePath)),
          SizedBox(height: 16),
          Text(
            extractedText,
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Scan Again')),
              ElevatedButton(onPressed: () {/* Save Logic */}, child: Text('Save')),
              ElevatedButton(onPressed: () {/* Share Logic */}, child: Text('Share')),
            ],
          ),
        ],
      ),
    );
  }
}
