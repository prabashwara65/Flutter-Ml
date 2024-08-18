import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';
import 'package:permission_handler/permission_handler.dart';

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
        onPressed: _checkPermissionsAndPickMedia,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _checkPermissionsAndPickMedia() async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      // If permission is granted, proceed to pick media
      _pickMedia();
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // If permission is denied, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to pick an image.')),
      );
    }
  }

  Future<void> _pickMedia() async {
    try {
      List<MediaFile>? media = await GalleryPicker.pickMedia(context: context, singleMedia: true);
      
      if (media != null && media.isNotEmpty) {
        var data = await media.first.getFile();
        print('Selected media path: ${data.path}'); // Debug print
        if (await data.exists()) {
          setState(() {
            selectedMedia = data;
          });
        } else {
          print('File does not exist');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
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
