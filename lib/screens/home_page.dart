import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? selectedMedia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Text Recognition'),
      ),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickMedia,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickMedia() async {
    try {
      List<MediaFile>? media = await GalleryPicker.pickMedia(context: context, singleMedia: true);
      
      if (media != null && media.isNotEmpty) {
        var mediaFile = media.first;
        // Verify that mediaFile is indeed a file and get its path
        var file = await mediaFile.getFile();
        
        if (file != null) {
          print('Selected media path: ${file.path}'); // Debug print
          if (await file.exists()) {
            print('File exists and can be accessed');
            setState(() {
              selectedMedia = file;
            });
          } else {
            print('File does not exist');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected file does not exist')),
            );
          }
        } else {
          print('Failed to get the file from media');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to get the file from media')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No media selected')),
        );
      }
    } catch (e) {
      print('Error picking media: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  Widget _buildUI() {
    return Center(
      child: selectedMedia == null
        ? const Text("No image selected")
        : Image.file(selectedMedia!, width: 200),
    );
  }
}
