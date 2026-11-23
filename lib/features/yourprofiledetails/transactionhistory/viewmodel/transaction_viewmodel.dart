
import 'package:flutter/material.dart';

enum TransactionType {
  bike,
  auto,
  scooty,
  parcelBike,
  parcelScooty,
}

class TransactionItem {
  final String title;
  final TransactionType type;
  final DateTime date;
  final double amount;
  final String method;
  final String paymentStatus;

  TransactionItem({
    required this.title,
    required this.type,
    required this.date,
    required this.amount,
    required this.method,
    this.paymentStatus = 'Successful',
  });

  bool get isParcel =>
      type == TransactionType.parcelBike ||
      type == TransactionType.parcelScooty;
}

class TransactionHistoryViewModel extends ChangeNotifier {
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<TransactionItem> _all = [
    TransactionItem(
      title: 'Bike Ride',
      type: TransactionType.bike,
      date: DateTime(2026, 10, 12, 12),
      amount: 120,
      method: 'Razor Pay + Wallet',
    ),
    TransactionItem(
      title: 'Auto Ride',
      type: TransactionType.auto,
      date: DateTime(2026, 10, 12, 12),
      amount: 67,
      method: 'Razor Pay',
    ),
    TransactionItem(
      title: 'Parcel Bike Ride',
      type: TransactionType.parcelBike,
      date: DateTime(2026, 10, 12, 12),
      amount: 43,
      method: 'Razor Pay',
    ),
    TransactionItem(
      title: 'Bike Ride',
      type: TransactionType.bike,
      date: DateTime(2026, 10, 12, 12),
      amount: 220,
      method: 'Razor Pay + Wallet',
    ),
    TransactionItem(
      title: 'Scooty Ride',
      type: TransactionType.scooty,
      date: DateTime(2026, 10, 12, 12),
      amount: 169,
      method: 'Razor Pay + Wallet',
    ),
    TransactionItem(
      title: 'Parcel Scooty Ride',
      type: TransactionType.parcelScooty,
      date: DateTime(2026, 10, 12, 12),
      amount: 104,
      method: 'Razor Pay',
    ),
    TransactionItem(
      title: 'Parcel Bike Ride',
      type: TransactionType.parcelBike,
      date: DateTime(2026, 10, 12, 12),
      amount: 111,
      method: 'Razor Pay',
    ),
    TransactionItem(
      title: 'Auto Ride',
      type: TransactionType.auto,
      date: DateTime(2026, 10, 12, 12),
      amount: 24,
      method: 'Razor Pay',
    ),
    TransactionItem(
      title: 'Auto Ride',
      type: TransactionType.auto,
      date: DateTime(2026, 10, 12, 12),
      amount: 120,
      method: 'Razor Pay',
    ),
    TransactionItem(
      title: 'Bike Ride',
      type: TransactionType.bike,
      date: DateTime(2026, 10, 12, 12),
      amount: 96,
      method: 'Razor Pay + Wallet',
    ),
    TransactionItem(
      title: 'Scooty Ride',
      type: TransactionType.scooty,
      date: DateTime(2026, 10, 12, 12),
      amount: 145,
      method: 'Razor Pay + Wallet',
    ),
    TransactionItem(
      title: 'Bike Ride',
      type: TransactionType.bike,
      date: DateTime(2026, 10, 12, 12),
      amount: 120,
      method: 'Razor Pay',
    ),
  ];

  String _query = '';

  DateTime? _selectedDate;

  String? selectedMonth;
  String? selectedService;
  String? selectedPaymentStatus;
  String? selectedPaymentMethod;

  String? draftMonth;
  String? draftService;
  String? draftPaymentStatus;
  String? draftPaymentMethod;

  DateTime? get selectedDate => _selectedDate;

  List<String> get monthOptions {
    return _all.map((item) {
      return '${_months[item.date.month - 1]} ${item.date.year}';
    }).toSet().toList();
  }

  List<String> get serviceOptions => [
        'Bike',
        'Auto',
        'Scooty',
        'Parcel Bike',
        'Parcel Scooty',
      ];

  List<String> get paymentStatusOptions => [
        'Successful',
        'Failed',
        'Pending',
      ];

  List<String> get paymentMethodOptions => [
        'Razor Pay',
        'Razor Pay + Wallet',
      ];

  List<TransactionItem> get items {
    final query = _query.trim().toLowerCase();

    return _all.where((item) {
      final matchesSearch = query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.method.toLowerCase().contains(query) ||
          formatDate(item.date).toLowerCase().contains(query) ||
          item.paymentStatus.toLowerCase().contains(query);

      final matchesDate = _selectedDate == null ||
          (item.date.year == _selectedDate!.year &&
              item.date.month == _selectedDate!.month &&
              item.date.day == _selectedDate!.day);

      final monthValue =
          '${_months[item.date.month - 1]} ${item.date.year}';

      final matchesMonth =
          selectedMonth == null || monthValue == selectedMonth;

      final matchesService = selectedService == null ||
          serviceName(item.type) == selectedService;

      final matchesStatus = selectedPaymentStatus == null ||
          item.paymentStatus == selectedPaymentStatus;

      final matchesMethod = selectedPaymentMethod == null ||
          item.method == selectedPaymentMethod;

      return matchesSearch &&
          matchesDate &&
          matchesMonth &&
          matchesService &&
          matchesStatus &&
          matchesMethod;
    }).toList();
  }

  String serviceName(TransactionType type) {
    switch (type) {
      case TransactionType.bike:
        return 'Bike';
      case TransactionType.auto:
        return 'Auto';
      case TransactionType.scooty:
        return 'Scooty';
      case TransactionType.parcelBike:
        return 'Parcel Bike';
      case TransactionType.parcelScooty:
        return 'Parcel Scooty';
    }
  }

  void search(String value) {
    _query = value;
    notifyListeners();
  }

  void selectDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  void openFilters() {
    draftMonth = selectedMonth;
    draftService = selectedService;
    draftPaymentStatus = selectedPaymentStatus;
    draftPaymentMethod = selectedPaymentMethod;
  }

  void changeMonth(String? value) {
    draftMonth = value;
    notifyListeners();
  }

  void changeService(String? value) {
    draftService = value;
    notifyListeners();
  }

  void changePaymentStatus(String? value) {
    draftPaymentStatus = value;
    notifyListeners();
  }

  void changePaymentMethod(String? value) {
    draftPaymentMethod = value;
    notifyListeners();
  }

  void applyFilters() {
    selectedMonth = draftMonth;
    selectedService = draftService;
    selectedPaymentStatus = draftPaymentStatus;
    selectedPaymentMethod = draftPaymentMethod;
    _selectedDate = null;
    notifyListeners();
  }

  void resetFilters() {
    draftMonth = null;
    draftService = null;
    draftPaymentStatus = null;
    draftPaymentMethod = null;

    selectedMonth = null;
    selectedService = null;
    selectedPaymentStatus = null;
    selectedPaymentMethod = null;

    _selectedDate = null;

    notifyListeners();
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${_months[date.month - 1].substring(0, 3)} ${date.year}';
  }

  String formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final suffix = date.hour >= 12 ? 'PM' : 'AM';

    return '${hour.toString().padLeft(2, '0')}:$minute $suffix';
  }

  String formatAmount(double amount) {
    return '₹${amount.toStringAsFixed(0)}';
  }
}
