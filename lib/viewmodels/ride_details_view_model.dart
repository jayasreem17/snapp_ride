import 'package:flutter/material.dart';

class RideHistoryItem {
  final String type;
  final String status;
  final String price;
  final String image;
  final IconData fallbackIcon;
  final String time;
  final String from;
  final String to;

  const RideHistoryItem({
    required this.type,
    required this.status,
    required this.price,
    required this.image,
    required this.fallbackIcon,
    this.time = 'Today, 10:30 AM',
    this.from = 'Madhapur Metro',
    this.to = 'KPHB Street shooping',
  });
}

class RideHistoryViewModel extends ChangeNotifier {
  final String title = 'Ride History';
  final List<String> tabs = const ['All', 'Completed', 'Cancelled'];
  final TextEditingController searchController = TextEditingController();

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  final List<RideHistoryItem> _rides = const [
    RideHistoryItem(
        type: 'Bike',
        status: 'Completed',
        price: '₹96',
        image: 'assets/images/bike.png',
        fallbackIcon: Icons.two_wheeler),
    RideHistoryItem(
        type: 'Cab',
        status: 'Cancelled',
        price: '₹0',
        image: 'assets/images/car.png',
        fallbackIcon: Icons.local_taxi),
    RideHistoryItem(
        type: 'Auto',
        status: 'Completed',
        price: '₹120',
        image: 'assets/images/auto.png',
        fallbackIcon: Icons.electric_rickshaw),
    RideHistoryItem(
        type: 'Auto',
        status: 'Completed',
        price: '₹165',
        image: 'assets/images/auto.png',
        fallbackIcon: Icons.electric_rickshaw),
    RideHistoryItem(
        type: 'Scooty Parcel Ride',
        status: 'Completed',
        price: '₹42',
        image: 'assets/images/parcel.png',
        fallbackIcon: Icons.inventory_2),
    RideHistoryItem(
        type: 'Bike',
        status: 'Completed',
        price: '₹39',
        image: 'assets/images/bike.png',
        fallbackIcon: Icons.two_wheeler),
    RideHistoryItem(
        type: 'Scooty',
        status: 'Cancelled',
        price: '₹80',
        image: 'assets/images/bike.png',
        fallbackIcon: Icons.two_wheeler),
    RideHistoryItem(
        type: 'Auto',
        status: 'Completed',
        price: '₹165',
        image: 'assets/images/auto.png',
        fallbackIcon: Icons.electric_rickshaw),
  ];

  List<RideHistoryItem> get rides {
    if (_selectedTab == 0) return _rides;
    final String status = tabs[_selectedTab];
    return _rides.where((r) => r.status == status).toList();
  }

  void selectTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}