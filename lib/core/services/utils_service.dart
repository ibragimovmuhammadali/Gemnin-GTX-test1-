import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<String> pickAndConvertImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return "";
    }

    final imageFile = File(pickedFile.path);
    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);
    return base64Image;
  }


}