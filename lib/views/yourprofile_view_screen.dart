
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../viewmodels/yourprofile_view_model.dart';
import './profile_details__screen.dart';

final green = Color(0xFF009640);
final black = Color(0xFF111111);
final lineColor = Color(0xFFE8E8E8);

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _webImageBytes;

  static final menu = {
    'Profile Details': Icons.person_outline,
    'Saved Addresses': Icons.bookmark_border,
    'My Wallet': Icons.account_balance_wallet_outlined,
    'Ride History': Icons.schedule,
    'Refer & Earn': Icons.schedule,
    'Help Center': Icons.help_outline,
    'Terms & Conditions': Icons.description_outlined,
    'Privacy policy': Icons.shield_outlined,
    'Help & Support': Icons.info_outline,
  };

  void navigateToScreen(BuildContext context, String title) {
    Widget page;

    switch (title) {
      case 'Profile Details':
        page = ProfileDetailsView();
        break;

      case 'Saved Addresses':
        page = PlaceholderScreen('Saved Addresses');
        break;

      case 'My Wallet':
        page = PlaceholderScreen('My Wallet');
        break;

      case 'Ride History':
        page = PlaceholderScreen('Ride History');
        break;

      case 'Refer & Earn':
        page = PlaceholderScreen('Refer & Earn');
        break;

      case 'Help Center':
        page = PlaceholderScreen('Help Center');
        break;

      case 'Terms & Conditions':
        page = PlaceholderScreen('Terms & Conditions');
        break;

      case 'Privacy policy':
        page = PlaceholderScreen('Privacy policy');
        break;

      case 'Help & Support':
        page = PlaceholderScreen('Help & Support');
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
    if (kIsWeb) {
      final imageBytes = await showDialog<Uint8List>(
        context: context,
        builder: (_) => _WebCameraDialog(),
      );

      if (imageBytes != null && mounted) {
        setState(() => _webImageBytes = imageBytes);
      }

      return;
    }

    setState(() => _webImageBytes = null);
    await context.read<ProfileViewModel>().pickImage(ImageSource.camera);
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
              leading: Icon(
                Icons.photo_library_outlined,
                color: Colors.green,
              ),
              title: Text(
                'Choose from Gallery',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(sheet);
                setState(() => _webImageBytes = null);
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
                          side: BorderSide(
                            color: cancelColor,
                            width: 1.2,
                          ),
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
            height: 56,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(icon, size: 22, color: black),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                  ),
                  if (arrow)
                    Icon(
                      Icons.chevron_right,
                      size: 22,
                      color: black,
                    ),
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
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: black,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Your Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => showPicker(context),
                    child: SizedBox(
                      width: 88,
                      height: 94,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          CircleAvatar(
                            radius: 44,
                            backgroundColor: Color(0xFFE6E6E6),
                            backgroundImage: _webImageBytes != null
                                ? MemoryImage(_webImageBytes!)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    vm.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B6B6B),
                      ),
                      children: [
                        TextSpan(text: 'Invite a friend Earn '),
                        TextSpan(
                          text: '₹50',
                          style: TextStyle(
                            color: green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Referral Code : ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                      Text(
                        vm.referralCode,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: black,
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
                        child: Icon(
                          Icons.copy,
                          size: 15,
                          color: black,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Share.share(
                          'Join Snapp Ride with my code ${vm.referralCode}',
                        ),
                        child: Icon(
                          Icons.share_outlined,
                          size: 15,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  for (final item in menu.entries)
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
                    onTap: () => showDeleteDialog(
                      context,
                      vm.deleteAccount,
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => showLogoutDialog(
                    context,
                    vm.logout,
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
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
  _WebCameraDialog();

  @override
  State<_WebCameraDialog> createState() => _WebCameraDialogState();
}

class _WebCameraDialogState extends State<_WebCameraDialog> {
  CameraController? controller;
  String? error;

  @override
  void initState() {
    super.initState();
    startCamera();
  }

  Future<void> startCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        setState(() => error = 'No camera found');
        return;
      }

      final c = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );

      await c.initialize();

      if (!mounted) return;

      setState(() => controller = c);
    } catch (e) {
      setState(
        () => error = 'Camera permission denied or not available',
      );
    }
  }

  Future<void> capture() async {
    final file = await controller!.takePicture();
    final bytes = await file.readAsBytes();

    if (mounted) {
      Navigator.pop(context, bytes);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Take a Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: black,
                ),
              ),
              SizedBox(height: 14),
              if (error != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    error!,
                    textAlign: TextAlign.center,
                  ),
                )
              else if (controller == null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: CircularProgressIndicator(color: green),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CameraPreview(controller!),
                ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: green,
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: green,
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
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: controller == null ? null : capture,
                        icon: Icon(
                          Icons.camera_alt,
                          size: 18,
                        ),
                        label: Text(
                          'Capture',
                          style: TextStyle(
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
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  PlaceholderScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
