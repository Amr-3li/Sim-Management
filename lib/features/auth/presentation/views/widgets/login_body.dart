import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/features/auth/presentation/views/widgets/login_actions.dart';
import 'package:sim_management_task/features/auth/presentation/views/widgets/login_header.dart';
import 'package:sim_management_task/features/auth/presentation/views/widgets/login_input.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalAuthentication localAuthentication = LocalAuthentication();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoginHeader(),
            const SizedBox(height: 32),
            LoginInput(
              phoneController: _phoneController,
              passwordController: _passwordController,
            ),
            const SizedBox(height: 24),
            LoginActions(
              phoneController: _phoneController,
              passwordController: _passwordController,
              formState: _formKey,
            ),
          ],
        ),
      ),
    );
  }
}
