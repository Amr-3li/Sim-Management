import 'package:flutter/material.dart';
import 'package:sim_management_task/features/auth/presentation/views/widgets/login_body.dart';

class AgentLoginPage extends StatefulWidget {
  const AgentLoginPage({super.key});
  static const String routeName = '/login';
  @override
  State<AgentLoginPage> createState() => _AgentLoginPageState();
}

class _AgentLoginPageState extends State<AgentLoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A8A), Color(0xFF1E40AF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: LoginBody(),
            ),
          ),
        ),
      ),
    );
  }
}
