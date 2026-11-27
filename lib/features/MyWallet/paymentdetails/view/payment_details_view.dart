import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project11/features/MyWallet/paymentdetails/viewmodel/payment_details_viewmodel.dart';

class PaymentDetailsView extends StatelessWidget {
  final String detailsKey;
  final String title;
  final String dateTime;
  final String amount;
  final String method;
  final String points;
  final String status;

  const PaymentDetailsView({
    super.key,
    required this.detailsKey,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.method,
    this.points = '',
    this.status = '',
  });

  static const Color green = Color(0xFF009640);
  static const Color lightGreen = Color(0xFFE6F5EC);
  static const Color grey = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE5E7EB);

  static const double sidePadding = 16;
  static const double cardGap = 20;
  static const double rowGap = 10;

  TextStyle inter(double size, FontWeight weight, Color color) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = PaymentDetailsViewModel(detailsKey);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildScrollArea(context, viewModel)),
            _buildBottomButtons(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollArea(BuildContext context, PaymentDetailsViewModel vm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(sidePadding, 24, sidePadding, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, vm),
          const SizedBox(height: 22),
          Text(
            vm.formatDate(dateTime),
            style: inter(12, FontWeight.w500, Colors.black),
          ),
          const SizedBox(height: 12),
          _buildTopCard(vm),
          ...vm.sections.entries.map(
            (section) => _buildSection(vm, section.key, section.value),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(PaymentDetailsViewModel vm) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        sidePadding,
        0,
        sidePadding,
        vm.hasHelpButton ? 24 : 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDownloadButton(vm),
          if (vm.hasHelpButton) ...[
            const SizedBox(height: 10),
            _buildHelpButton(vm),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PaymentDetailsViewModel vm) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => vm.onBack(context),
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFFF3F4F6),
            child: Icon(Icons.arrow_back_ios_new, size: 13, color: Colors.black),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Payment Details',
          style: inter(16, FontWeight.w500, Colors.black),
        ),
      ],
    );
  }

  Widget _buildTopCard(PaymentDetailsViewModel vm) {
    return _card(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _buildIconBox(vm),
          const SizedBox(width: 10),
          Expanded(child: _buildTitleColumn()),
          const SizedBox(width: 8),
          _buildAmountColumn(),
        ],
      ),
    );
  }

  Widget _buildIconBox(PaymentDetailsViewModel vm) {
    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(vm.icon, size: 15, color: Colors.black87),
    );
  }

  Widget _buildTitleColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: inter(10, FontWeight.w600, Colors.black),
              ),
            ),
            if (status.isNotEmpty)
              _buildStatusBadge()
            else if (points.isNotEmpty)
              _buildPointsBadge(),
          ],
        ),
        const SizedBox(height: 3),
        Text(dateTime, style: inter(8, FontWeight.w400, grey)),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(status, style: inter(6.5, FontWeight.w600, Colors.white)),
    );
  }

  Widget _buildPointsBadge() {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(points, style: inter(7, FontWeight.w600, Colors.orange)),
    );
  }

  Widget _buildAmountColumn() {
    final bool isRed = amount.startsWith('-') || status.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(amount, style: inter(10, FontWeight.w600, isRed ? Colors.red : green)),
        const SizedBox(height: 3),
        Text(method, style: inter(8, FontWeight.w400, grey)),
      ],
    );
  }

  Widget _buildSection(
    PaymentDetailsViewModel vm,
    String sectionTitle,
    List<List<String>> rows,
  ) {
    final bool isSingleRowCard = sectionTitle.isEmpty;

    return Padding(
      padding: const EdgeInsets.only(top: cardGap),
      child: _card(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: isSingleRowCard ? 12 : 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSingleRowCard) _buildSectionTitle(sectionTitle),
            ..._buildRows(vm, rows, isSingleRowCard),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: inter(12, FontWeight.w600, Colors.black)),
    );
  }

  List<Widget> _buildRows(
    PaymentDetailsViewModel vm,
    List<List<String>> rows,
    bool isSingleRowCard,
  ) {
    final List<Widget> widgets = [];

    for (int i = 0; i < rows.length; i++) {
      final bool total = isSingleRowCard || vm.isTotal(rows[i][0]);

      if (i != 0) {
        widgets.add(total ? _buildDivider() : const SizedBox(height: rowGap));
      }
      widgets.add(_buildRow(rows[i], total));
    }

    return widgets;
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(height: 1, thickness: 1, color: borderColor),
    );
  }

  Widget _buildRow(List<String> row, bool total) {
    if (row.length == 1) return _buildNote(row[0]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            row[0],
            style: total
                ? inter(11, FontWeight.w600, Colors.black)
                : inter(10, FontWeight.w400, grey),
          ),
        ),
        const SizedBox(width: 8),
        Text(row[1], style: _valueStyle(row[1], total)),
      ],
    );
  }

  TextStyle _valueStyle(String value, bool total) {
    if (value == 'Processing') return inter(10, FontWeight.w600, Colors.orange);
    if (total) return inter(11, FontWeight.w600, green);
    return inter(10, FontWeight.w500, Colors.black);
  }

  Widget _buildNote(String text) {
    return Text(text, style: inter(8.5, FontWeight.w400, grey));
  }

  Widget _buildDownloadButton(PaymentDetailsViewModel vm) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: vm.onDownloadInvoice,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          'Download Invoice',
          style: inter(12, FontWeight.w600, Colors.white),
        ),
      ),
    );
  }

  Widget _buildHelpButton(PaymentDetailsViewModel vm) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: vm.onHelpSupport,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: green, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          'Help & Support',
          style: inter(12, FontWeight.w600, green),
        ),
      ),
    );
  }

  Widget _card({required Widget child, required EdgeInsets padding}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}