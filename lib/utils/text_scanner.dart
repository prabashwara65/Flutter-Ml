import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class TextScanner {
  static final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();

  static Future<String> scanFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      // Save the image to the app's directory
      final savedImage = await _saveImage(imageFile);

      final inputImage = InputImage.fromFilePath(savedImage.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      return recognizedText.text;
    }
    return '';
  }

  static Future<File> _saveImage(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/images/';
    final imageDir = Directory(imagePath);

    // Check if the directory exists
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }

    // Save the image to the directory
    final savedImagePath = '${imagePath}${DateTime.now().millisecondsSinceEpoch}.jpg';
    return File(image.path).copy(savedImagePath);
  }

  static void dispose() {
    _textRecognizer.close();
  }
}
