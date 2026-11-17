
import 'package:flutter/material.dart';

class SavedAddressView extends StatefulWidget {
  const SavedAddressView({super.key});

  @override
  State<SavedAddressView> createState() => _SavedAddressViewState();
}

class _SavedAddressViewState extends State<SavedAddressView> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  final Color primaryColor = const Color(0xFF009640);

  final List<Map<String, dynamic>> addresses = [
    {
      'title': 'Office',
      'address': 'Analogue IT Solutions, hitech city road',
      'icon': Icons.work_outline,
    },
    {
      'title': 'Home',
      'address': 'Cyber Towers, Hitech City Main Rd',
      'icon': Icons.home_outlined,
    },
    {
      'title': 'Home',
      'address': 'Cyber Towers, Hitech City Main Rd',
      'icon': Icons.home_outlined,
    },
    {
      'title': 'Hostel',
      'address': 'Shamshabad, Hyderabad',
      'icon': Icons.location_on_outlined,
    },
    {
      'title': 'Hostel',
      'address': 'Shamshabad, Hyderabad',
      'icon': Icons.location_on_outlined,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredAddresses = addresses.where((address) {
      return address['title']
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          address['address']
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0F5F2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Saved Addresses',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF172033),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: Colors.black54,
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search Location, name',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 21,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Saved Address List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFECE8F5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredAddresses.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      thickness: 0.7,
                      color: Color(0xFFE5E5E5),
                      indent: 44,
                    );
                  },
                  itemBuilder: (context, index) {
                    final address = filteredAddresses[index];

                    return SizedBox(
                      height: 51,
                      child: Row(
                        children: [
                          Container(
                            height: 26,
                            width: 26,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE7F5ED),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              address['icon'],
                              size: 17,
                              color: const Color(0xFF202820),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  address['title'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  address['address'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Static Add New Address
              Container(
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFECE8F5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),

                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      'Add New Address',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
