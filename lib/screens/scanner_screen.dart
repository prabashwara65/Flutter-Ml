import 'package:flutter/material.dart';
import 'package:flutter_ml/utils/text_scanner.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _extractedText = '';

  Future<void> _scanText() async {
    final extractedText = await TextScanner.scanFromCamera();
    setState(() {
      _extractedText = extractedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Text')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _scanText,
            child: Text('Capture Image'),
          ),
          SizedBox(height: 16),
          Text(
            _extractedText,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
