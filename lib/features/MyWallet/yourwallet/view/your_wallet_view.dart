import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project11/features/MyWallet/addmoney/view/addmoney_view.dart';
import 'package:flutter_project11/features/MyWallet/earninghistory/view/earning_history_view.dart';
import 'package:flutter_project11/features/MyWallet/paymentdetails/view/payment_details_view.dart';
import 'package:flutter_project11/features/MyWallet/yourwallet/viewmodel/your_wallet_viewmodel.dart';
import 'package:provider/provider.dart';

class YourWalletView extends StatelessWidget {
  const YourWalletView({super.key});

  static const green = Color(0xff009640);
  static const lightGreen = Color(0xFFE6F5EC);
  static const lightRed = Color(0xFFFDECEC);
  static const grey = Color(0xFF6B7280);
  static const borderColor = Color(0xFFE5E7EB);

  TextStyle inter(double size, FontWeight weight, Color color) {
    return GoogleFonts.inter(fontSize: size, fontWeight: weight, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WalletViewModel(),
      child: Consumer<WalletViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              titleSpacing: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xFFF3F4F6),
                  child: Icon(Icons.arrow_back_ios_new, size: 13, color: Colors.black),
                ),
              ),
              title: Text('Your Wallet', style: inter(15, FontWeight.w600, const Color(0xFF111827))),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                children: [
                  _buildBalanceCard(vm),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: amountCard('Credited', '₹${vm.credited.toStringAsFixed(2)}', Icons.login, green, lightGreen)),
                      const SizedBox(width: 10),
                      Expanded(child: amountCard('Debited', '₹${vm.debited.toStringAsFixed(2)}', Icons.logout, Colors.red, lightRed)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildAddMoneyCard(context),
                  const SizedBox(height: 10),
                  _buildPointsCard(vm),
                  const SizedBox(height: 10),
                  _buildReferralCard(vm),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      tab('Earnings History', 0, 11, vm),
                      tab('Pending Refunds', 1, 9, vm),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildSearchRow(context, vm),
                  const SizedBox(height: 14),
                  _buildTransactionList(context, vm),
                  const SizedBox(height: 14),
                  _buildViewAll(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildBalanceCard(WalletViewModel vm) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 94,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00A745), Color(0xFF007D35)],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: CurvePainter())),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Balance', style: inter(9.5, FontWeight.w500, Colors.white)),
                        const SizedBox(height: 4),
                        Text('₹${vm.balance.toStringAsFixed(2)}', style: inter(21, FontWeight.w700, Colors.white)),
                        const SizedBox(height: 4),
                        Text('Use Wallet amount for rides', style: inter(7, FontWeight.w500, Colors.white)),
                      ],
                    ),
                  ),
                  Image.asset('assets/images/objects.png', height: 56, width: 56),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMoneyCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddMoneyView()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: boxStyle(),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 13,
              backgroundColor: lightGreen,
              child: Icon(Icons.add, color: green, size: 16),
            ),
            const SizedBox(height: 6),
            Text('Add Money', style: inter(9.5, FontWeight.w600, Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(WalletViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.black, Color(0xFF005C2B), green]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: inter(9.5, FontWeight.w500, Colors.white),
                  children: [
                    TextSpan(text: '${vm.points} ', style: inter(9.5, FontWeight.w700, Colors.orange)),
                    const TextSpan(text: 'Points'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text('₹10 added in Wallet', style: inter(7, FontWeight.w500, Colors.white)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.two_wheeler, color: Colors.black, size: 12),
              ),
              const SizedBox(height: 4),
              Text('10 Points = 5 rupees', style: inter(7, FontWeight.w500, Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCard(WalletViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF00A745), Color(0xFF008A3A)]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildRupeeIcon(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${vm.referrals} Referrals', style: inter(7.5, FontWeight.w500, Colors.white)),
                const SizedBox(height: 3),
                Text('${vm.referrals * 50} Points', style: inter(11.5, FontWeight.w700, Colors.white)),
                const SizedBox(height: 3),
                Text('10 Points = 5 rupees', style: inter(7, FontWeight.w500, Colors.white)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Total Earnings', style: inter(7.5, FontWeight.w500, Colors.white)),
              const SizedBox(height: 3),
              Text('₹${vm.totalEarnings.toStringAsFixed(2)}', style: inter(13.5, FontWeight.w700, Colors.white)),
              const SizedBox(height: 3),
              Text('Added in Wallet', style: inter(7, FontWeight.w500, Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRupeeIcon() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: const Color(0x33D9D9D9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          height: 32,
          width: 32,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Center(
            child: Text('₹', style: inter(20, FontWeight.w800, green)),
          ),
        ),
      ),
    );
  }


  Widget _buildSearchRow(BuildContext context, WalletViewModel vm) {
    return Row(
      children: [
        Expanded(child: _buildSearchBox(context, vm)),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _openFilter(context, vm),
          child: Icon(
            Icons.tune,
            size: 20,
            color: vm.hasFilter ? green : const Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox(BuildContext context, WalletViewModel vm) {
    return Container(
      height: 39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF111827), width: 2)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 16, color: Color(0xFF111827)),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  controller: vm.searchController,
                  onChanged: vm.onSearchChanged,
                  style: inter(9.5, FontWeight.w500, Colors.black),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: vm.selectedDate ?? 'Search Location, date',
                    hintStyle: inter(9.5, FontWeight.w400, grey),
                  ),
                ),
              ),
              if (vm.selectedDate != null)
                GestureDetector(
                  onTap: vm.clearDate,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.close, size: 14, color: Colors.red),
                  ),
                ),
              GestureDetector(
                onTap: () => vm.pickDate(context),
                child: const Icon(Icons.calendar_month_outlined, size: 16, color: Color(0xFF111827)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewAll(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EarningHistoryView()),
        );
      },
      child: Text('View All', style: inter(11.5, FontWeight.w700, green)),
    );
  }


  void _openFilter(BuildContext context, WalletViewModel vm) {
    vm.loadDraft();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (sheetContext) {
        return ChangeNotifierProvider.value(
          value: vm,
          child: Consumer<WalletViewModel>(
            builder: (context, vm, child) => _buildFilterSheet(context, vm),
          ),
        );
      },
    );
  }

  Widget _buildFilterSheet(BuildContext context, WalletViewModel vm) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(child: _buildFilterCard(vm)),
            ),
            const SizedBox(height: 12),
            _buildFilterButtons(context, vm),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.arrow_back_ios_new, size: 13, color: Colors.black),
          ),
        ),
        const SizedBox(width: 12),
        Text('Filter', style: inter(14, FontWeight.w600, Colors.black)),
      ],
    );
  }

  Widget _buildFilterCard(WalletViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterDropdown(
            vm: vm,
            label: 'Payment Mode',
            hint: 'Select Payment mode',
            name: 'payment',
            value: vm.draftPaymentMode,
            options: vm.filterPaymentModes,
            onSelect: vm.selectPaymentMode,
          ),
          const SizedBox(height: 16),
          _buildFilterDropdown(
            vm: vm,
            label: 'Year',
            hint: 'Select Year',
            name: 'year',
            value: vm.draftYear,
            options: vm.filterYears,
            onSelect: vm.selectYear,
          ),
          const SizedBox(height: 16),
          _buildFilterDropdown(
            vm: vm,
            label: 'Month',
            hint: 'Select Month',
            name: 'month',
            value: vm.draftMonth,
            options: vm.filterMonths,
            onSelect: vm.selectMonth,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required WalletViewModel vm,
    required String label,
    required String hint,
    required String name,
    required String? value,
    required List<String> options,
    required Function(String) onSelect,
  }) {
    final bool isOpen = vm.openDropdown == name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: inter(8.5, FontWeight.w600, Colors.black)),
        const SizedBox(height: 8),
        _buildFilterField(hint, value, isOpen, () => vm.toggleDropdown(name)),
        if (isOpen) _buildFilterOptions(options, value, onSelect),
      ],
    );
  }

  Widget _buildFilterField(String hint, String? value, bool isOpen, VoidCallback onTap) {
    final bool hasValue = value != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value ?? hint,
                style: inter(
                  8,
                  hasValue ? FontWeight.w600 : FontWeight.w400,
                  hasValue ? Colors.black : grey,
                ),
              ),
            ),
            Icon(
              isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOptions(List<String> options, String? selected, Function(String) onSelect) {
    final List<Widget> items = [];

    for (int i = 0; i < options.length; i++) {
      if (i != 0) {
        items.add(const Divider(height: 1, thickness: 1, color: borderColor));
      }
      items.add(_buildFilterOption(options[i], options[i] == selected, onSelect));
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Column(children: items),
      ),
    );
  }

  Widget _buildFilterOption(String text, bool isSelected, Function(String) onSelect) {
    return InkWell(
      onTap: () => onSelect(text),
      child: Container(
        width: double.infinity,
        color: isSelected ? lightGreen : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          text,
          style: inter(8, isSelected ? FontWeight.w600 : FontWeight.w400, Colors.black),
        ),
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context, WalletViewModel vm) {
    return Row(
      children: [
        Expanded(child: _buildResetButton(vm)),
        const SizedBox(width: 12),
        Expanded(child: _buildApplyButton(context, vm)),
      ],
    );
  }

  Widget _buildResetButton(WalletViewModel vm) {
    return SizedBox(
      height: 38,
      child: OutlinedButton(
        onPressed: vm.resetFilter,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text('Reset', style: inter(9, FontWeight.w600, Colors.black)),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context, WalletViewModel vm) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed: () => vm.applyFilter(context),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text('Apply Filters', style: inter(9, FontWeight.w600, Colors.white)),
      ),
    );
  }


  Widget _buildTransactionList(BuildContext context, WalletViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: boxStyle(),
      child: vm.transactions.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Text('No transactions found', style: inter(10.5, FontWeight.w500, Colors.black)),
              ),
            )
          : Column(
              children: vm.transactions
                  .map((item) => _buildTransactionItem(context, item))
                  .toList(),
            ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, dynamic item) {
    return InkWell(
      onTap: () => _openDetails(context, item),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
        ),
        child: Row(
          children: [
            _buildItemIcon(item),
            const SizedBox(width: 10),
            Expanded(child: _buildItemTitle(item)),
            const SizedBox(width: 8),
            _buildItemAmount(item),
          ],
        ),
      ),
    );
  }

  Widget _buildItemIcon(dynamic item) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(item['icon'], size: 14, color: Colors.black87),
    );
  }

  Widget _buildItemTitle(dynamic item) {
    final String status = item['status'] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                item['title'],
                overflow: TextOverflow.ellipsis,
                style: inter(8.5, FontWeight.w600, Colors.black),
              ),
            ),
            if (status.isNotEmpty)
              _buildStatusBadge(status)
            else if (item['badge'] != '')
              _buildBadge(item['badge']),
          ],
        ),
        const SizedBox(height: 3),
        Text(item['date'], style: inter(7, FontWeight.w400, grey)),
      ],
    );
  }

  Widget _buildStatusBadge(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: inter(6.5, FontWeight.w600, Colors.white)),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(text, style: inter(7, FontWeight.w600, Colors.orange)),
    );
  }

  Widget _buildItemAmount(dynamic item) {
    final Color amountColor = item['amount'].startsWith('+') ? green : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(item['amount'], style: inter(8.5, FontWeight.w700, amountColor)),
        const SizedBox(height: 3),
        Text(item['type'], style: inter(7, FontWeight.w400, grey)),
      ],
    );
  }

  void _openDetails(BuildContext context, dynamic item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetailsView(
          detailsKey: item['detailsKey'] ?? item['title'],
          title: item['title'],
          dateTime: item['date'],
          amount: item['amount'],
          method: item['type'],
          points: item['badge'],
          status: item['status'] ?? '',
        ),
      ),
    );
  }


  BoxDecoration boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE5E7EB)),
      boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2))],
    );
  }

  Widget amountCard(String title, String amount, IconData icon, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: boxStyle(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: inter(8.5, FontWeight.w500, grey)),
                const SizedBox(height: 4),
                Text(amount, style: inter(10.5, FontWeight.w700, Colors.black)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
              boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Icon(icon, color: color, size: 10),
          ),
        ],
      ),
    );
  }

  Widget tab(String text, int index, int flex, WalletViewModel vm) {
    final selected = vm.selectedTab == index;
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => vm.changeTab(index),
        child: Column(
          children: [
            Text(
              text,
              style: inter(10.5, FontWeight.w600, selected ? green : Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(height: 2, color: selected ? Colors.black : Colors.transparent),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w * 0.55, h)
      ..cubicTo(w * 0.58, h * 0.80, w * 0.62, h * 0.50, w * 0.72, h * 0.48)
      ..cubicTo(w * 0.80, h * 0.46, w * 0.86, h * 0.60, w * 0.92, h * 0.40)
      ..cubicTo(w * 0.95, h * 0.30, w * 0.98, h * 0.34, w, h * 0.30)
      ..lineTo(w, h)
      ..close();

    canvas.drawPath(path, Paint()..color = const Color(0xFF1FA155));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}