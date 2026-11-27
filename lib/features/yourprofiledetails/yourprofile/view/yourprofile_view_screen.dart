import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project11/features/yourprofiledetails/helpcenter/view/help_center_screen.dart';
import 'package:flutter_project11/features/yourprofiledetails/helpsupport/view/help_support_screen.dart';
import 'package:flutter_project11/features/MyWallet/yourwallet/view/your_wallet_view.dart';
import 'package:flutter_project11/features/yourprofiledetails/privacydetails/view/privacy_view_screen.dart';
import 'package:flutter_project11/features/yourprofiledetails/referandearn/view/refer_view_screen.dart';
import 'package:flutter_project11/features/completeridehistory/ridehistorydetails/view/ride_history_view.dart';
import 'package:flutter_project11/features/yourprofiledetails/termconditions/view/terms_view_screen.dart';
import 'package:flutter_project11/features/yourprofiledetails/transactionhistory/view/transaction_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../saveddetails/view/saved_address_view_screen.dart';
import '../viewmodel/yourprofile_view_model.dart';
import '../../profiledetails/view/profile_details__screen.dart';

final green = Color(0xFF009640);
final black = Color(0xFF111111);
final lineColor = Color(0xFFE8E8E8);
final bannerGreen = Color(0xFFE6F4EA);
final iconGrey = Color(0xFF111827);

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static final menu = <MapEntry<String, IconData>>[
    MapEntry('Profile Details', Icons.person_outline),
    MapEntry('Saved Addresses', Icons.bookmark_border),
    MapEntry('My Wallet', Icons.account_balance_wallet_outlined),
    MapEntry('Ride History', Icons.schedule),
    MapEntry('Transaction History', Icons.receipt_long_outlined),
    MapEntry('Refer & Earn', Icons.person_add_alt_1_outlined),
    MapEntry('Help Center', Icons.help_outline),
    MapEntry('Terms & Conditions', Icons.assignment_outlined),
    MapEntry('Privacy policy', Icons.shield_outlined),
    MapEntry('Help & Support', Icons.info_outline),
  ];

  void navigateToScreen(BuildContext context, String title) {
    Widget page;

    switch (title) {
      case 'Profile Details':
        page = ProfileDetailsViewScreen();
        break;
      case 'Saved Addresses':
        page = SavedAddressesViewScreen();
        break;
      case 'Ride History':
        page = RideHistoryView();
        break;
      case 'Transaction History':
        page = TransactionHistoryScreen();
        break;
      case 'My Wallet':
        page = YourWalletView();
        break;
      case 'Refer & Earn':
        page = ReferAndEarnViewScreen();
        break;
      case 'Help Center':
        page = HelpCenterViewScreen();
        break;
      case 'Terms & Conditions':
        page = TermsAndConditionsViewScreen();
        break;
      case 'Privacy policy':
        page = PrivacyPolicyViewScreen();
        break;
      case 'Help & Support':
        page = HelpSupportViewScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<void> openCamera(BuildContext context) async {
    final vm = context.read<ProfileViewModel>();

    if (kIsWeb) {
      final imageBytes = await showDialog<Uint8List>(
        context: context,
        builder: (_) => _WebCameraDialog(),
      );

      if (imageBytes != null) {
        vm.setImageBytes(imageBytes);
      }
      return;
    }

    await vm.pickImage(ImageSource.camera);
  }

  void showPicker(BuildContext context) {
    final vm = context.read<ProfileViewModel>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.camera_alt_outlined, color: green),
              title: Text(
                'Take a Photo',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(sheet);
                openCamera(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined, color: green),
              title: Text(
                'Choose from Gallery',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(sheet);
                vm.pickImage(ImageSource.gallery);
              },
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void showConfirmDialog(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String message,
    required Color cancelColor,
    required Color confirmColor,
    required String confirmText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (d) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 22, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              SizedBox(height: 14),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: Color(0xFF6B6B6B),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: cancelColor, width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () => Navigator.pop(d),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: cancelColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: confirmColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(d);
                          onConfirm();
                        },
                        child: Text(
                          confirmText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, VoidCallback onConfirm) {
    showConfirmDialog(
      context,
      icon: Icons.warning_amber_rounded,
      iconColor: Color(0xFFF57C00),
      iconBg: Color(0xFFFFEFE0),
      title: 'Delete Account?',
      message: 'Deleting your account will permanently remove your profile.',
      cancelColor: green,
      confirmColor: green,
      confirmText: 'Delete',
      onConfirm: onConfirm,
    );
  }

  void showLogoutDialog(BuildContext context, VoidCallback onConfirm) {
    showConfirmDialog(
      context,
      icon: Icons.logout,
      iconColor: Color(0xFFD32F2F),
      iconBg: Color(0xFFFDE8E8),
      title: 'Log Out?',
      message: 'Are you sure you want to Log out of your account?',
      cancelColor: Color(0xFFD32F2F),
      confirmColor: Color(0xFFB00000),
      confirmText: 'Log Out',
      onConfirm: onConfirm,
    );
  }

  void showRemovePhotoDialog(BuildContext context, VoidCallback onConfirm) {
    showConfirmDialog(
      context,
      icon: Icons.delete_outline,
      iconColor: Color(0xFFD32F2F),
      iconBg: Color(0xFFFDE8E8),
      title: 'Remove Photo?',
      message: 'Are you sure you want to remove your profile photo?',
      cancelColor: green,
      confirmColor: green,
      confirmText: 'Remove',
      onConfirm: onConfirm,
    );
  }

  Widget menuRow({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool arrow = true,
    bool line = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 52,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(icon, size: 20, color: iconGrey),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: iconGrey,
                      ),
                    ),
                  ),
                  if (arrow)
                    Icon(Icons.chevron_right, size: 20, color: iconGrey),
                ],
              ),
            ),
          ),
        ),
        if (line)
          Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: lineColor,
          ),
      ],
    );
  }

  Widget smallIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: lineColor, width: 1),
        ),
        child: Icon(icon, size: 11, color: color),
      ),
    );
  }

  Widget banner(BuildContext context, ProfileViewModel vm) {
    return Container(
      width: double.infinity,
      color: bannerGreen,
      padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => showPicker(context),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFD9D9D9),
                    backgroundImage: vm.imageBytes != null
                        ? MemoryImage(vm.imageBytes!)
                        : null,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    smallIconButton(
                      icon: Icons.edit_outlined,
                      color: green,
                      onTap: () => showPicker(context),
                    ),
                    SizedBox(width: 8),
                    smallIconButton(
                      icon: Icons.delete_outline,
                      color: Color(0xFFD32F2F),
                      onTap: () {
                        if (vm.imageBytes == null) return;
                        showRemovePhotoDialog(context, vm.removeImage);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vm.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B6B6B),
                    ),
                    children: [
                      TextSpan(text: 'Invite a friend Earn '),
                      TextSpan(
                        text: '${vm.points} Points',
                        style: TextStyle(
                          color: green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 32,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: lineColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4A4A4A),
                            ),
                            children: [
                              TextSpan(text: 'Referral Code : '),
                              TextSpan(
                                text: vm.referralCode,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: black,
                                ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: vm.referralCode),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Code copied')),
                          );
                        },
                        child: Icon(Icons.copy, size: 13, color: black),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          SharePlus.instance.share(
                            ShareParams(
                              text:
                                  'Join Snapp Ride with my code ${vm.referralCode}',
                            ),
                          );
                        },
                        child: Icon(
                          Icons.share_outlined,
                          size: 13,
                          color: black,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Text(
          'Your Profile',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  banner(context, vm),
                  SizedBox(height: 8),
                  for (final item in menu)
                    menuRow(
                      icon: item.value,
                      title: item.key,
                      onTap: () => navigateToScreen(context, item.key),
                    ),
                  menuRow(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    arrow: false,
                    line: false,
                    onTap: () => showDeleteDialog(context, vm.deleteAccount),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () => showLogoutDialog(context, vm.logout),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WebCameraDialog extends StatefulWidget {
  @override
  State<_WebCameraDialog> createState() => _WebCameraDialogState();
}

class _WebCameraDialogState extends State<_WebCameraDialog> {
  CameraController? _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw StateError('No camera is available.');
      }

      final controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _controller = controller;
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = 'Unable to access the camera.';
        });
      }
    }
  }

  Future<void> _takePicture() async {
    final controller = _controller;

    if (controller == null || !controller.value.isInitialized) return;

    try {
      final image = await controller.takePicture();

      if (!mounted) return;

      Navigator.of(context).pop(await image.readAsBytes());
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = 'Unable to capture the photo.';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return AlertDialog(
      title: Text('Take a Photo'),
      content: SizedBox(
        width: 400,
        child: controller != null && controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(_error ?? 'Starting camera...'),
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        FilledButton(
          onPressed: controller != null && controller.value.isInitialized
              ? _takePicture
              : null,
          child: Text('Capture'),
        ),
      ],
    );
  }
}