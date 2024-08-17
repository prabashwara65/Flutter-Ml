import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:gallery_picker/models/media_file.dart';

class HomePage extends StatelessWidget {
  File? selectedMedia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Text Recognition'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<MediaFile>? media = await GalleryPicker.pickMedia(context: context, singleMedia: true);
        },
        child: const Icon(Icons.add),
      ),
      
    );
  }
}
