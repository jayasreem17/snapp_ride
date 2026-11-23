import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  String name = 'Arjun Aryan';
  String referralCode = 'AJ126332IQ';
  int points = 50;
  Uint8List? imageBytes;

  Future<void> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 80);
    if (picked == null) return;
    imageBytes = await picked.readAsBytes();
    notifyListeners();
  }

  void setImageBytes(Uint8List bytes) {
    imageBytes = bytes;
    notifyListeners();
  }

  void removeImage() {
    imageBytes = null;
    notifyListeners();
  }

  void logout() {}

  void deleteAccount() {}
}