import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? selectedMedia;
  String? extractedText; // To hold the extracted text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Text Recognition'),
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (await file.exists()) {
        setState(() {
          selectedMedia = file;
          extractedText = null; // Reset extracted text when a new image is picked
        });
        _extractText(file); // Extract text as soon as the image is picked
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected file does not exist')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  Widget _buildUI() {
    return Center(
      child: selectedMedia == null
        ? const Text("No image selected")
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(selectedMedia!, width: 200),
              const SizedBox(height: 20),
              _extractTextView(),
            ],
          ),
    );
  }

  Widget _extractTextView() {
    if (extractedText == null) {
      return const Center(
        child: Text("Extracting text...", style: TextStyle(fontSize: 18)),
      );
    }
    return Text(
      extractedText!,
      style: const TextStyle(fontSize: 18),
    );
  }

  Future<void> _extractText(File file) async {
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFile(file);
    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      setState(() {
        extractedText = recognizedText.text;
      });
    } catch (e) {
      print('Error extracting text: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to extract text')),
      );
    } finally {
      textRecognizer.close();
    }
  }
}
