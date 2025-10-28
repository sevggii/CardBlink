import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

/// OCR Service
/// Handles text recognition from images
/// Uses ML Kit for mobile and Tesseract for web
abstract class OCRService {
  Future<String> recognizeText(XFile image);
}

/// ML Kit implementation for mobile platforms
class MLKitOCRService implements OCRService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  @override
  Future<String> recognizeText(XFile image) async {
    try {
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = 
          await _textRecognizer.processImage(inputImage);

      return recognizedText.text;
    } catch (e) {
      throw Exception('Failed to recognize text: $e');
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}

/// Tesseract.js implementation for web platform
/// Note: Actual Tesseract.js integration would require JavaScript interop
/// This is a placeholder that can be extended with js package
class TesseractOCRService implements OCRService {
  @override
  Future<String> recognizeText(XFile image) async {
    try {
      // For web, we'll need to use JavaScript interop with Tesseract.js
      // This is a simplified version - in production, you'd use dart:js or js package
      // to call Tesseract.js functions
      
      // Read image bytes
      final bytes = await image.readAsBytes();
      
      // TODO: Implement actual Tesseract.js integration via JavaScript interop
      // For now, return a placeholder message
      throw UnimplementedError(
        'Web OCR requires Tesseract.js integration via JavaScript interop. '
        'Image size: ${bytes.length} bytes'
      );
    } catch (e) {
      throw Exception('Failed to recognize text on web: $e');
    }
  }
}

/// Factory to get the appropriate OCR service based on platform
class OCRServiceFactory {
  static OCRService create() {
    if (kIsWeb) {
      return TesseractOCRService();
    } else {
      return MLKitOCRService();
    }
  }
}

