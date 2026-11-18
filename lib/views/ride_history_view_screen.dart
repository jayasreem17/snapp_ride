import 'package:flutter/material.dart';
import 'package:flutter_project11/viewmodels/ride_details_view_model.dart';


class RideHistoryViewScreen extends StatefulWidget {
  const RideHistoryViewScreen({super.key});

  @override
  State<RideHistoryViewScreen> createState() => _RideHistoryViewScreenState();
}

class _RideHistoryViewScreenState extends State<RideHistoryViewScreen> {
  final RideHistoryViewModel viewModel = RideHistoryViewModel();

  static const Color primary = Color(0xFF009640);
  static const Color cancelRed = Color(0xFFD70000);
  static const Color titleColor = Color(0xFF111827);
  static const String font = 'Inter';

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Widget _badge(String status) {
    final bool done = status == 'Completed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: done ? primary : cancelRed,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontFamily: font,
          fontSize: 8,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _rideCard(RideHistoryItem ride) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: Image.asset(
              ride.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(ride.fallbackIcon, size: 36, color: primary),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        ride.type,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: font,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    _badge(ride.status),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  ride.time,
                  style: const TextStyle(
                    fontFamily: font,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 11, color: primary),
                    const SizedBox(width: 2),
                    Text(
                      ride.from,
                      style: const TextStyle(
                        fontFamily: font,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '·······',
                      style: TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.location_on, size: 11, color: cancelRed),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        ride.to,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: font,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: titleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ride.price,
                  style: const TextStyle(
                    fontFamily: font,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward,
                      size: 9, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final rides = viewModel.rides;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.goBack(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_left,
                              size: 24, color: titleColor),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        viewModel.title,
                        style: const TextStyle(
                          fontFamily: font,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: const Color(0xFF374151)),
                          ),
                          child: TextField(
                            controller: viewModel.searchController,
                            style: const TextStyle(
                                fontFamily: font,
                                fontSize: 13,
                                color: titleColor),
                            decoration: const InputDecoration(
                              hintText: 'Search Location, date',
                              hintStyle: TextStyle(
                                fontFamily: font,
                                fontSize: 13,
                                color: Color(0xFF6B7280),
                              ),
                              prefixIcon: Icon(Icons.search,
                                  color: titleColor, size: 20),
                              suffixIcon: Icon(Icons.calendar_month_outlined,
                                  color: titleColor, size: 20),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.tune, size: 22, color: titleColor),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                  child: Row(
                    children: [
                      for (int i = 0; i < viewModel.tabs.length; i++)
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => viewModel.selectTab(i),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: viewModel.selectedTab == i
                                        ? primary
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                viewModel.tabs[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: font,
                                  fontSize: 14,
                                  fontWeight: viewModel.selectedTab == i
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: viewModel.selectedTab == i
                                      ? primary
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    itemCount: rides.length,
                    itemBuilder: (context, index) => _rideCard(rides[index]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}