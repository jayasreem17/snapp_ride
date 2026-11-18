import 'package:flutter/material.dart';
import '../viewmodels/saved_details_viewmodel.dart';

class SavedAddressesViewScreen extends StatefulWidget {
  const SavedAddressesViewScreen({super.key});

  @override
  State<SavedAddressesViewScreen> createState() =>
      _SavedAddressesViewScreenState();
}

class _SavedAddressesViewScreenState extends State<SavedAddressesViewScreen> {
  final SavedAddressesViewModel viewModel = SavedAddressesViewModel();

  static const Color primary = Color(0xFF009640);
  static const Color titleColor = Color(0xFF111827);
  static const String font = 'Inter';

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFEBEDEF)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
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
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.goBack(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_left,
                              size: 22, color: titleColor),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        viewModel.title,
                        style: const TextStyle(
                          fontFamily: font,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF374151)),
                    ),
                    child: TextField(
                      controller: viewModel.searchController,
                      style: const TextStyle(
                          fontFamily: font, fontSize: 12, color: titleColor),
                      decoration: const InputDecoration(
                        hintText: 'Search Location, name',
                        hintStyle: TextStyle(
                          fontFamily: font,
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                        prefixIcon:
                            Icon(Icons.search, color: titleColor, size: 18),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: _cardDecoration(),
                    child: Column(
                      children: [
                        for (int i = 0; i < viewModel.addresses.length; i++)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: i == viewModel.addresses.length - 1
                                      ? Colors.transparent
                                      : const Color(0xFFEDEFF0),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF1F5F4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(viewModel.addresses[i].icon,
                                      size: 17, color: titleColor),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewModel.addresses[i].title,
                                        style: const TextStyle(
                                          fontFamily: font,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: titleColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        viewModel.addresses[i].address,
                                        style: const TextStyle(
                                          fontFamily: font,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => viewModel.addNewAddress(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: _cardDecoration(),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add,
                                size: 18, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Add New Address',
                            style: TextStyle(
                              fontFamily: font,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: titleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}