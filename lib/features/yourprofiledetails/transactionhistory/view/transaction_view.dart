
import 'package:flutter/material.dart';
import 'package:flutter_project11/features/yourprofiledetails/transactionhistory/viewmodel/transaction_viewmodel.dart';
import 'package:provider/provider.dart';

final _green = Color(0xFF009640);
final _textDark = Color(0xFF111111);
final _textGrey = Color(0xFF858585);
final _line = Color(0xFFE8E8E8);
final _blueBox = Color(0xFFEAF4FA);

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionHistoryViewModel(),
      child: _TransactionHistoryBody(),
    );
  }
}

class _TransactionHistoryBody extends StatelessWidget {
  _TransactionHistoryBody();

  Future<void> pickDate(
    BuildContext context,
    TransactionHistoryViewModel vm,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: vm.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _green,
              onPrimary: Colors.white,
              onSurface: _textDark,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              headerBackgroundColor: Colors.white,
              headerForegroundColor: _textDark,
              dividerColor: _line,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      vm.selectDate(picked);
    }
  }

  void openFilter(
    BuildContext context,
    TransactionHistoryViewModel vm,
  ) {
    vm.openFilters();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: vm,
          child: TransactionFilterScreen(),
        ),
      ),
    );
  }

  Widget searchBar(
    BuildContext context,
    TransactionHistoryViewModel vm,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 36,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xFFD9D9D9),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(1, 1),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 16,
                  color: Color(0xFF777777),
                ),
                SizedBox(width: 9),
                Expanded(
                  child: TextField(
                    onChanged: vm.search,
                    style: TextStyle(
                      fontSize: 11,
                      color: _textDark,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search Location, date',
                      hintStyle: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF888888),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => pickDate(context, vm),
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _blueBox,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.calendar_month_outlined,
                      size: 13,
                      color: Color(0xFF737D84),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => openFilter(context, vm),
          child: Icon(
            Icons.tune,
            size: 19,
            color: Color(0xFF777777),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionHistoryViewModel>();
    final items = vm.items;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF7F9F8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 13,
                        color: _textDark,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Transaction History',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: searchBar(context, vm),
            ),
            SizedBox(height: 12),
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        'No transactions found',
                        style: TextStyle(
                          fontSize: 12,
                          color: _textGrey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        thickness: 1,
                        color: _line,
                      ),
                      itemBuilder: (context, index) {
                        return _TransactionRow(
                          item: items[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final TransactionItem item;

  _TransactionRow({required this.item});

  IconData get rideIcon {
    switch (item.type) {
      case TransactionType.bike:
        return Icons.two_wheeler;
      case TransactionType.auto:
        return Icons.electric_rickshaw;
      case TransactionType.scooty:
        return Icons.two_wheeler;
      case TransactionType.parcelBike:
      case TransactionType.parcelScooty:
        return Icons.inventory_2_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<TransactionHistoryViewModel>();

    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xFFE6F4EA),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Icon(
              rideIcon,
              size: 17,
              color: Color(0xFF26332C),
            ),
          ),
          SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '${vm.formatDate(item.date)}  |  ${vm.formatTime(item.date)}',
                  style: TextStyle(
                    fontSize: 9,
                    color: _textGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                vm.formatAmount(item.amount),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _green,
                ),
              ),
              SizedBox(height: 2),
              Text(
                item.method,
                style: TextStyle(
                  fontSize: 9,
                  color: _textGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionFilterScreen extends StatelessWidget {
  TransactionFilterScreen({super.key});

  Widget filterField({
    required String title,
    required String? value,
    required List<String> options,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: _textDark,
          ),
        ),
        SizedBox(height: 7),
        Container(
          height: 38,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Color(0xFFE8E8E8)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                'Select',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF888888),
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: Color(0xFF777777),
              ),
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 11,
                      color: _textDark,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionHistoryViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F9F8),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 13,
                        color: _textDark,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFF0F0F0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    filterField(
                      title: 'Month',
                      value: vm.draftMonth,
                      options: vm.monthOptions,
                      onChanged: vm.changeMonth,
                    ),
                    SizedBox(height: 16),
                    filterField(
                      title: 'Service',
                      value: vm.draftService,
                      options: vm.serviceOptions,
                      onChanged: vm.changeService,
                    ),
                    SizedBox(height: 16),
                    filterField(
                      title: 'Payment Status',
                      value: vm.draftPaymentStatus,
                      options: vm.paymentStatusOptions,
                      onChanged: vm.changePaymentStatus,
                    ),
                    SizedBox(height: 16),
                    filterField(
                      title: 'Payment Method',
                      value: vm.draftPaymentMethod,
                      options: vm.paymentMethodOptions,
                      onChanged: vm.changePaymentMethod,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 30),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: OutlinedButton(
                        onPressed: vm.resetFilters,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _green,
                          side: BorderSide(color: _green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {
                          vm.applyFilters();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
