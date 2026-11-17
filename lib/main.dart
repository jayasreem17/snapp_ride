import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/yourprofile_view_model.dart';
import '../views/yourprofile_view_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => ProfileViewModel(),
        child:  ProfileScreen(),
      ),
    ),
  );
}