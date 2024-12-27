import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage(ImageSource source) async {
  try {
    final XFile? image = await ImagePicker().pickImage(source: source);
    debugPrint("hello");
    if (image != null) {
      debugPrint("hello");
      return image;
    } else {
      return null;
    }
  } catch (e) {
    debugPrint("Error picking image: $e");
    return null;
  }
}
