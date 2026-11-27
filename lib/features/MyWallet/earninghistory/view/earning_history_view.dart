
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project11/features/MyWallet/earninghistory/viewmodel/earning_history_viewmodel.dart';
import 'package:provider/provider.dart';

class EarningHistoryView extends StatelessWidget {
  EarningHistoryView({super.key});

  static final green = Color(0xff009640);
  static final lightGreen = Color(0xFFE6F5EC);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EarningHistoryViewModel(),
      child: Consumer<EarningHistoryViewModel>(
        builder: (context, vm, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.apply(
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                titleSpacing: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xFFF3F4F6),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Text(
                  'Earnings History',
                  style: GoogleFonts.inter(
                    color: Color(0xFF111827),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFD1D5DB),
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xFF111827),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 18,
                                      color: Color(0xFF111827),
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: TextField(
                                        controller: vm.searchController,
                                        onChanged: vm.onSearchChanged,
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          hintText: vm.selectedDate ??
                                              'Search Location, date',
                                          hintStyle: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (vm.selectedDate != null)
                                      GestureDetector(
                                        onTap: vm.clearDate,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    GestureDetector(
                                      onTap: () => vm.pickDate(context),
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        size: 18,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => vm.openFilter(context),
                          child: Icon(
                            Icons.tune,
                            size: 22,
                            color: vm.filterType == 'All'
                                ? Color(0xFF111827)
                                : green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFE5E7EB),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: vm.transactions.isEmpty
                            ? Center(
                                child: Text(
                                  'No transactions found',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView(
                                padding: EdgeInsets.zero,
                                children: vm.transactions.map((item) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: lightGreen,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Icon(
                                            item['icon'],
                                            size: 17,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      item['title'],
                                                      style: GoogleFonts.inter(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  if (item['badge'] != '')
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        left: 6,
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFFF3E0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Text(
                                                        item['badge'],
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.orange,
                                                          fontSize: 7,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                item['date'],
                                                style: GoogleFonts.inter(
                                                  fontSize: 8,
                                                  color: Color(0xFF6B7280),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              item['amount'],
                                              style: GoogleFonts.inter(
                                                color: item['amount']
                                                        .startsWith('+')
                                                    ? green
                                                    : Colors.red,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              item['type'],
                                              style: GoogleFonts.inter(
                                                fontSize: 8,
                                                color: Color(0xFF6B7280),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
