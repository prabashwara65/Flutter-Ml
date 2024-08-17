import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class TextScanner {
  static final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();

  static Future<String> scanFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      final inputImage = InputImage.fromFilePath(imageFile.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      return recognizedText.text;
    }
    return '';
  }

  static void dispose() {
    _textRecognizer.close();
  }
}
