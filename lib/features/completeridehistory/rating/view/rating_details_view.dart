import 'package:flutter/material.dart';
import 'package:flutter_project11/features/completeridehistory/rating/viewmodel/rating_details_viewmodel.dart';

const Color _green = Color(0xFF009640);

class DriverRatingView extends StatefulWidget {
  const DriverRatingView({super.key});

  @override
  State<DriverRatingView> createState() => _DriverRatingViewState();
}

class _DriverRatingViewState extends State<DriverRatingView> {
  DriverRatingViewModel vm = DriverRatingViewModel();

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                                          color: const Color.fromARGB(255, 249, 247, 247),


              ),
              child: const Icon(Icons.chevron_left, size: 20, color: Colors.black),
            ),
          ),
        ),
        title: const Text('Driver Rating', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)),
      ),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    children: [
                      const Text('Rate Your Ride', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE3E3E3)),
                          boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
                        ),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 26,
                              backgroundColor: Color(0xFFD9D9D9),
                              child: Icon(Icons.person, color: Colors.white, size: 30),
                            ),
                            const SizedBox(height: 8),
                            const Text('Arjun Kumar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (i) {
                                bool filled = i < vm.rating;
                                return InkWell(
                                  onTap: () => vm.setRating(i + 1),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: Icon(
                                      filled ? Icons.star_rounded : Icons.star_border_rounded,
                                      size: 34,
                                      color: filled ? const Color(0xFFF5B301) : Colors.black,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE3E3E3)),
                              ),
                              child: TextField(
                                controller: vm.commentController,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 12),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add a comment...',
                                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () => vm.submit(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}