
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project11/features/completeridehistory/ridehistorydetails/viewmodel/ride_history_viewmodel.dart';

Color _green = Color(0xFF009640);

class RideHistoryView extends StatelessWidget {
  RideHistoryView({super.key});

  Widget dropdown(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xFFE3E3E3)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: Colors.white,
                hint: Text(
                  'Select',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                style: TextStyle(fontSize: 11, color: Colors.black),
                items: items.map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RideHistoryViewModel(),
      child: Consumer<RideHistoryViewModel>(
        builder: (context, vm, child) {
          if (vm.showFilter) {
            return filterPage(context, vm);
          }

          return historyPage(context, vm);
        },
      ),
    );
  }

  Widget historyPage(BuildContext context, RideHistoryViewModel vm) {
    List<Map<String, dynamic>> rides = vm.filteredRides;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 249, 247, 247),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: Text(
          'Ride History',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: vm.searchController,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'Search Location, date',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => vm.pickDate(context),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                InkWell(
                  onTap: vm.openFilter,
                  child: Icon(
                    Icons.tune,
                    size: 20,
                    color: vm.filterApplied ? _green : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: List.generate(3, (i) {
                bool selected = vm.selectedTab == i;

                return Expanded(
                  child: InkWell(
                    onTap: () => vm.changeTab(i),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selected ? _green : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          vm.tabs[i],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? _green
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: rides.isEmpty
                ? Center(
                    child: Text(
                      'No rides found',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(16, 18, 16, 20),
                    itemCount: rides.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> r = rides[index];
                      bool cancelled = r['status'] == 'Cancelled';

                      return InkWell(
                        onTap: () => vm.openRideDetails(context, r),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFEDEDED),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                r['image'],
                                width: 36,
                                height: 36,
                                errorBuilder: (c, e, s) {
                                  return Image.asset(
                                    'assets/images/bike.png',
                                    width: 36,
                                    height: 36,
                                  );
                                },
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            r['title'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (vm.selectedTab == 0) ...[
                                          SizedBox(width: 6),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: cancelled
                                                  ? Color(0xFFC40000)
                                                  : _green,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              r['status'],
                                              style: TextStyle(
                                                fontSize: 8.5,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                        SizedBox(width: 6),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFF1DC),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            '${r['points']} Points',
                                            style: TextStyle(
                                              fontSize: 8.5,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFF08A00),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'From : Madhapur → To : KPHB',
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      '${r['date']}, ${r['time']}',
                                      style: TextStyle(fontSize: 10.5),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹${r['amount']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 14),
                                  Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFDDF3E5),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 8,
                                      color: _green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget filterPage(BuildContext context, RideHistoryViewModel vm) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: vm.closeFilter,
          icon: Icon(Icons.arrow_back_ios_new_outlined, size: 20),
        ),
        title: Text(
          'Filter',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE3E3E3)),
                ),
                child: Column(
                  children: [
                    dropdown('Month', vm.month, vm.months, (v) {
                      vm.month = v;
                      vm.update();
                    }),
                    dropdown('Service', vm.service, vm.services, (v) {
                      vm.service = v;
                      vm.update();
                    }),
                    if (vm.selectedTab == 0)
                      dropdown(
                        'Ride Status',
                        vm.rideStatus,
                        vm.rideStatuses,
                        (v) {
                          vm.rideStatus = v;
                          vm.update();
                        },
                      ),
                    dropdown(
                      'Payment Status',
                      vm.paymentStatus,
                      vm.paymentStatuses,
                      (v) {
                        vm.paymentStatus = v;
                        vm.update();
                      },
                    ),
                    dropdown(
                      'Payment Method',
                      vm.paymentMethod,
                      vm.paymentMethods,
                      (v) {
                        vm.paymentMethod = v;
                        vm.update();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: vm.resetFilter,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: _green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _green,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: vm.closeFilter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'Apply Filters',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
    );
  }
}
