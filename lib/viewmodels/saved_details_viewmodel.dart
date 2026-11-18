import 'package:flutter/material.dart';

class SavedAddressItem {
  final String title;
  final String address;
  final IconData icon;

  const SavedAddressItem(this.title, this.address, this.icon);
}

class SavedAddressesViewModel extends ChangeNotifier {
  final String title = 'Saved Addresses';
  final TextEditingController searchController = TextEditingController();

  final List<SavedAddressItem> addresses = const [
    SavedAddressItem('Office', 'Analogue IT Solutions, hitech city road',
        Icons.business_center_outlined),
    SavedAddressItem('Home', 'Cyber Towers, Hitech City Main Rd',
        Icons.home_outlined),
    SavedAddressItem('Home', 'Cyber Towers, Hitech City Main Rd',
        Icons.home_outlined),
    SavedAddressItem(
        'Hostel', 'Shamshabad, Hyderabad', Icons.location_on_outlined),
    SavedAddressItem(
        'Hostel', 'Shamshabad, Hyderabad', Icons.location_on_outlined),
  ];

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  void addNewAddress(BuildContext context) {}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}