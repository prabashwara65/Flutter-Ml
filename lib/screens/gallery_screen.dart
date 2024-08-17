import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<FileSystemEntity> _images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesDirectory = Directory('${directory.path}/images');
    if (imagesDirectory.existsSync()) {
      setState(() {
        _images = imagesDirectory.listSync().where((item) => item.path.endsWith(".png") || item.path.endsWith(".jpg")).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: _images.isEmpty
          ? Center(child: Text('No images found'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.file(File(_images[index].path), fit: BoxFit.cover);
              },
            ),
    );
  }
}
