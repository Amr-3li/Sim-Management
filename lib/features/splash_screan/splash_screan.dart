// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_management_task/core/services/sharedpreference_singelton.dart';
import 'package:sim_management_task/features/auth/presentation/views/page/agent_login_page.dart';
import 'package:sim_management_task/features/sim_management/presentation/views/pages/sim_management_page.dart';
import 'package:sim_management_task/features/splash_screan/widgets/splash_body.dart';

class SplashScrean extends StatefulWidget {
  const SplashScrean({super.key});

  @override
  State<SplashScrean> createState() => _SplashScreanState();
}

class _SplashScreanState extends State<SplashScrean>
    with WidgetsBindingObserver {
  double opacity = 0.0;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startFlow();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// يبدأ الفلو الكامل
  Future<void> _startFlow() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() => opacity = 1.0);

    await _handlePermissions();
  }

  /// فحص وطلب الصلاحيات
  Future<void> _handlePermissions() async {
    final smsStatus = await Permission.sms.status;
    final phoneStatus = await Permission.phone.status;

    if (smsStatus.isGranted && phoneStatus.isGranted) {
      _navigateNext();
      return;
    }

    /// لو مرفوض بشكل عادي
    if (smsStatus.isDenied || phoneStatus.isDenied) {
      final smsRequest = await Permission.sms.request();
      final phoneRequest = await Permission.phone.request();

      if (smsRequest.isGranted && phoneRequest.isGranted) {
        _navigateNext();
      } else {
        _showPermissionDialog();
      }
      return;
    }

    /// لو permanently denied
    if (smsStatus.isPermanentlyDenied || phoneStatus.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

  /// عند الرجوع من Settings
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _recheckAfterSettings();
    }
  }

  Future<void> _recheckAfterSettings() async {
    final smsStatus = await Permission.sms.status;
    final phoneStatus = await Permission.phone.status;

    if (!mounted) return;

    if (smsStatus.isGranted && phoneStatus.isGranted) {
      if (_isDialogShowing) {
        Navigator.of(context, rootNavigator: true).pop();
        _isDialogShowing = false;
      }
      _navigateNext();
    }
  }

  /// التنقل بعد الموافقة
  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final isLogged = SharedPreferenceSingelton.getBool('islogedin') ?? false;

    if (isLogged) {
      context.go(SimManagementPage.routeName);
    } else {
      context.go(AgentLoginPage.routeName);
    }
  }

  /// Dialog في حالة الرفض العادي
  void _showPermissionDialog() {
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Permission Required"),
        content: const Text(
          "SMS and Phone permissions are required to read SIM messages.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              _isDialogShowing = false;
              _handlePermissions();
            },
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }

  /// Dialog في حالة permanently denied
  void _showSettingsDialog() {
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Permission Required"),
        content: const Text(
          "Permission permanently denied. Please enable it from settings.",
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              _isDialogShowing = false;
              await openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashBody(opacity: opacity));
  }
}
