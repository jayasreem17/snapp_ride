import 'package:flutter/material.dart';

class WalletViewModel extends ChangeNotifier {
  double balance = 1000;
  double credited = 320;
  double debited = 220;
  double totalEarnings = 100;
  int referrals = 4;
  int points = 20;
  int selectedTab = 0;
  String filterType = 'All';
  String? selectedDate;

  final searchController = TextEditingController();

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
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Pending Payment Refund', 'amount': '+₹120', 'type': 'Razor Pay', 'badge': '', 'date': '12 Oct 2026  |  12:00 PM'},
  ];

  List get transactions {
    var list = selectedTab == 0 ? earnings : pendingRefunds;

    final query = searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((e) => e['title'].toString().toLowerCase().contains(query) || e['date'].toString().toLowerCase().contains(query)).toList();
    }

    if (selectedDate != null) {
      list = list.where((e) => e['date'].toString().contains(selectedDate!)).toList();
    }

    if (filterType == 'Credited') {
      list = list.where((e) => e['amount'].toString().startsWith('+')).toList();
    }

    if (filterType == 'Debited') {
      list = list.where((e) => e['amount'].toString().startsWith('-')).toList();
    }

    return list;
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

  void openFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: ['All', 'Credited', 'Debited'].map((type) {
            return ListTile(
              title: Text(type),
              trailing: filterType == type ? const Icon(Icons.check, color: Color(0xff009640)) : null,
              onTap: () {
                filterType = type;
                notifyListeners();
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void addMoney() {}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}