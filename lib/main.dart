import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:sim_management_task/core/services/sharedpreference_singelton.dart';
import 'package:sim_management_task/core/utils/app_theme.dart';
import 'package:sim_management_task/core/utils/routing.dart';
import 'package:sim_management_task/core/di/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetItSetup();
  await SharedPreferenceSingelton.init();

  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.appRouter,
    );
  }
}
