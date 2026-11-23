import 'package:flutter/material.dart';

class DriverRatingViewModel extends ChangeNotifier {
  int rating = 0;
  TextEditingController commentController = TextEditingController();

  void setRating(int value) {
    rating = value;
    notifyListeners();
  }

  void submit(BuildContext context) {
    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a rating')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFFE3F5E9),
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Color(0xFF009640), size: 22),
            SizedBox(width: 10),
            Text(
              'Feedback Submitted Successfully.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}