import 'package:flutter/material.dart';

class ReportViewModel extends ChangeNotifier {
  int selected = 0;
  TextEditingController complaintController = TextEditingController();

  List<String> reasons = [
    'Rude or Inappropriate Behaviour',
    'Unsafe Driving',
    'Driver Asked for Extra Money',
    'Route Deviation',
    'Vehicle Safety or Cleanliness Issue',
    'Other Issues',
  ];

  void selectReason(int index) {
    selected = index;
    notifyListeners();
  }

  void submit(BuildContext context) {
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
              'Report Submitted Successfully.',
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
    complaintController.dispose();
    super.dispose();
  }
}