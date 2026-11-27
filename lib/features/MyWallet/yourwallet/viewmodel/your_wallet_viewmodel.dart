import 'package:flutter/material.dart';

class WalletViewModel extends ChangeNotifier {
  double balance = 1000;
  double credited = 320;
  double debited = 220;
  double totalEarnings = 100;
  int referrals = 4;
  int points = 20;
  int selectedTab = 0;
  String? selectedDate;

  final searchController = TextEditingController();

  final filterPaymentModes = [
    'All Credited',
    'All Debited',
    'Refunds',
    'Referrals',
    'Ride Points',
    'Add Money',
  ];
  final filterYears = ['2026', '2027'];
  final filterMonths = ['November', 'December'];

  String? filterPaymentMode;
  String? filterYear;
  String? filterMonth;

  String? draftPaymentMode;
  String? draftYear;
  String? draftMonth;
  String openDropdown = '';

  final earnings = [
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Pending Payment Refund', 'amount': '+₹120', 'type': 'Razor Pay', 'badge': '', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Snapp Ride Bonus', 'amount': '+₹200', 'type': 'Razor Pay', 'badge': '', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Ride Refund Money', 'amount': '+₹20', 'type': 'Razor Pay', 'badge': '', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Ride Points Money', 'amount': '+₹5', 'type': 'Cash Payment', 'badge': '10 Points', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.person_add_alt_1_outlined, 'title': 'Referral Money', 'amount': '+₹50', 'type': '', 'badge': '50 Points', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.add, 'title': 'Add Money', 'amount': '+₹200', 'type': 'UPI Payment', 'badge': '', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.two_wheeler, 'title': 'Bike Ride', 'amount': '-₹20', 'type': 'Razor Pay + Wallet', 'badge': '', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.inventory_2, 'title': 'Parcel Ride', 'amount': '-₹20', 'type': 'Razor Pay + Wallet', 'badge': '', 'date': '12 Oct 2026  |  12:00 PM'},
  ];

  final pendingRefunds = [
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Pending Payment Refund', 'amount': '₹80', 'type': 'Razor Pay', 'badge': '', 'status': 'Pending', 'detailsKey': 'Pending: Pending Payment Refund', 'date': '12 Oct 2026  |  12:00 PM'},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Ride Refund Money', 'amount': '₹15', 'type': 'Razor Pay', 'badge': '', 'status': 'Pending', 'detailsKey': 'Pending: Ride Refund Money', 'date': '12 Oct 2026  |  12:00 PM'},
  ];

  bool get hasFilter {
    return filterPaymentMode != null || filterYear != null || filterMonth != null;
  }

  List get transactions {
    var list = selectedTab == 0 ? earnings : pendingRefunds;

    final query = searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((e) => e['title'].toString().toLowerCase().contains(query) || e['date'].toString().toLowerCase().contains(query)).toList();
    }

    if (selectedDate != null) {
      list = list.where((e) => e['date'].toString().contains(selectedDate!)).toList();
    }

    if (filterPaymentMode != null) {
      list = list.where(matchesPaymentMode).toList();
    }

    if (filterYear != null) {
      list = list.where((e) => e['date'].toString().contains(filterYear!)).toList();
    }

    if (filterMonth != null) {
      list = list.where(matchesMonth).toList();
    }

    return list;
  }

  bool matchesPaymentMode(Map item) {
    final title = item['title'].toString();
    final amount = item['amount'].toString();

    switch (filterPaymentMode) {
      case 'All Credited':
        return amount.startsWith('+');
      case 'All Debited':
        return amount.startsWith('-');
      case 'Refunds':
        return title.contains('Refund');
      case 'Referrals':
        return title.contains('Referral');
      case 'Ride Points':
        return title.contains('Ride Points');
      case 'Add Money':
        return title == 'Add Money';
      default:
        return true;
    }
  }

  bool matchesMonth(Map item) {
    final shortMonth = filterMonth!.substring(0, 3);
    return item['date'].toString().contains(' $shortMonth ');
  }

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  void onSearchChanged(String value) {
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null) {
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      selectedDate = '${picked.day.toString().padLeft(2, '0')} ${months[picked.month - 1]} ${picked.year}';
      notifyListeners();
    }
  }

  void clearDate() {
    selectedDate = null;
    notifyListeners();
  }

  void loadDraft() {
    draftPaymentMode = filterPaymentMode;
    draftYear = filterYear;
    draftMonth = filterMonth;
    openDropdown = '';
  }

  void toggleDropdown(String name) {
    openDropdown = openDropdown == name ? '' : name;
    notifyListeners();
  }

  void selectPaymentMode(String value) {
    draftPaymentMode = value;
    openDropdown = '';
    notifyListeners();
  }

  void selectYear(String value) {
    draftYear = value;
    openDropdown = '';
    notifyListeners();
  }

  void selectMonth(String value) {
    draftMonth = value;
    openDropdown = '';
    notifyListeners();
  }

  void resetFilter() {
    draftPaymentMode = null;
    draftYear = null;
    draftMonth = null;
    openDropdown = '';
    notifyListeners();
  }

  void applyFilter(BuildContext context) {
    filterPaymentMode = draftPaymentMode;
    filterYear = draftYear;
    filterMonth = draftMonth;
    Navigator.pop(context);
    notifyListeners();
  }

  void addMoney() {}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}