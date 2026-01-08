// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_management_task/core/services/sharedpreference_singelton.dart';
import 'package:sim_management_task/features/auth/presentation/views/page/agent_login_page.dart';
import 'package:sim_management_task/features/sim_management/presentation/views/pages/sim_management_page.dart';
import 'package:sim_management_task/features/splash_screan/widgets/splash_body.dart';

class SplashScrean extends StatefulWidget {
  const SplashScrean({super.key});

  @override
  State<SplashScrean> createState() => _SplashScreanState();
}

class _SplashScreanState extends State<SplashScrean> {
  double opacity = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Future.delayed(const Duration(seconds: 7), () async {
      if (SharedPreferenceSingelton.getBool('islogedin') == true) {
        GoRouter.of(context).pushReplacement(SimManagementPage.routeName);
      } else {
        GoRouter.of(context).pushReplacement(AgentLoginPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashBody(opacity: opacity));
  }
}
