
import 'package:flutter/material.dart';
import 'package:flutter_project11/features/completeridehistory/ridedetails/view/ride_details_view.dart';

class RideHistoryViewModel extends ChangeNotifier {
  int selectedTab = 0;
  bool showFilter = false;

  TextEditingController searchController = TextEditingController();

  List<String> tabs = ['All', 'Completed', 'Cancelled'];

  String? month;
  String? service;
  String? rideStatus;
  String? paymentStatus;
  String? paymentMethod;

  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  List<String> services = ['Bike', 'Cab', 'Auto', 'Scooty', 'Scooty Parcel'];

  List<String> rideStatuses = ['Completed', 'Cancelled'];

  List<String> paymentStatuses = ['Successful', 'Pending'];

  List<String> paymentMethods = [
    'Razor Pay', 'Cash', 'Wallet', 'Razor Pay + Wallet'
  ];

  List<Map<String, dynamic>> rides = [
    {'title': 'Bike', 'image': 'assets/images/bike.png', 'status': 'Completed', 'points': 16, 'amount': 130, 'date': 'Today', 'time': '10:30 AM', 'paymentStatus': 'Successful', 'paymentMethod': 'Razor Pay + Wallet'},
    {'title': 'Cab', 'image': 'assets/images/car.png', 'status': 'Cancelled', 'points': 10, 'amount': 196, 'date': 'Today', 'time': '6:30 AM', 'paymentStatus': 'Successful', 'paymentMethod': 'Razor Pay'},
    {'title': 'Auto', 'image': 'assets/images/auto.png', 'status': 'Completed', 'points': 20, 'amount': 120, 'date': '12 Oct 2026', 'time': '10:30 AM', 'paymentStatus': 'Successful', 'paymentMethod': 'Cash'},
    {'title': 'Auto', 'image': 'assets/images/auto.png', 'status': 'Completed', 'points': 26, 'amount': 165, 'date': '11 Oct 2026', 'time': '2:00 PM', 'paymentStatus': 'Successful', 'paymentMethod': 'Razor Pay'},
    {'title': 'Scooty Parcel', 'image': 'assets/images/parcel.png', 'status': 'Completed', 'points': 5, 'amount': 42, 'date': '11 Oct 2026', 'time': '2:00 PM', 'paymentStatus': 'Pending', 'paymentMethod': 'Razor Pay'},
    {'title': 'Scooty', 'image': 'assets/images/scooty.png', 'status': 'Completed', 'points': 16, 'amount': 66, 'date': '10 Oct 2026', 'time': '10:30 AM', 'paymentStatus': 'Successful', 'paymentMethod': 'Cash'},
    {'title': 'Bike', 'image': 'assets/images/bike.png', 'status': 'Completed', 'points': 16, 'amount': 130, 'date': '10 Oct 2026', 'time': '10:30 AM', 'paymentStatus': 'Successful', 'paymentMethod': 'Razor Pay + Wallet'},
  ];

  RideHistoryViewModel() {
    searchController.addListener(() {
      notifyListeners();
    });
  }

  List<Map<String, dynamic>> get filteredRides {
    String q = searchController.text.trim().toLowerCase();

    return rides.where((r) {
      if (selectedTab == 1 && r['status'] != 'Completed') return false;
      if (selectedTab == 2 && r['status'] != 'Cancelled') return false;

      String rideMonth = r['date'] == 'Today'
          ? months[DateTime.now().month - 1].substring(0, 3)
          : r['date'].split(' ')[1];

      if (month != null && !month!.startsWith(rideMonth)) return false;
      if (service != null && r['title'] != service) return false;
      if (rideStatus != null && r['status'] != rideStatus) return false;
      if (paymentStatus != null && r['paymentStatus'] != paymentStatus) return false;
      if (paymentMethod != null && r['paymentMethod'] != paymentMethod) return false;

      String text = '${r['title']} Madhapur KPHB ${r['date']}'.toLowerCase();

      return text.contains(q);
    }).toList();
  }

  bool get filterApplied {
    return month != null ||
        service != null ||
        rideStatus != null ||
        paymentStatus != null ||
        paymentMethod != null;
  }

  void update() {
    notifyListeners();
  }

  void changeTab(int index) {
    selectedTab = index;

    if (index != 0) {
      rideStatus = null;
    }

    notifyListeners();
  }

  void openFilter() {
    showFilter = true;
    notifyListeners();
  }

  void closeFilter() {
    showFilter = false;
    notifyListeners();
  }

  void resetFilter() {
    month = null;
    service = null;
    rideStatus = null;
    paymentStatus = null;
    paymentMethod = null;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    List<String> shortMonths = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 40),
        child: SizedBox(
          width: 320,
          height: 340,
          child: CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2025),
            lastDate: DateTime(2027),
            onDateChanged: (d) => Navigator.pop(ctx, d),
          ),
        ),
      ),
    );

    if (picked != null) {
      searchController.text =
          '${picked.day} ${shortMonths[picked.month - 1]} ${picked.year}';
    }
  }

  void openRideDetails(BuildContext context, Map<String, dynamic> ride) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RideDetailsView(ride: ride),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
