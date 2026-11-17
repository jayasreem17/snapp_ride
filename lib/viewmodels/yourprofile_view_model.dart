import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  String name = 'Arjun Aryan';
  String referralCode = 'AJ126332IQ';
  File? image;

  // source = ImageSource.camera or ImageSource.gallery
  Future<void> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 80);
    if (picked == null) return;
    image = File(picked.path);
    notifyListeners();
  }

  void logout() {
    // TODO: clear session
  }

  void deleteAccount() {
    // TODO: call delete API
  }
}