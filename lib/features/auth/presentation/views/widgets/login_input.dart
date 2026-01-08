import 'package:flutter/material.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';
import 'package:sim_management_task/features/auth/presentation/views/widgets/custom_text_field.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({
    super.key,
    required this.phoneController,
    required this.passwordController,
  });

  final TextEditingController phoneController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: AppStrings.phoneNumberLabel,
          hint: AppStrings.phoneNumberHint,
          prefixIcon: Icons.phone_outlined,
          isRequired: true,
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        // Password Field
        CustomTextField(
          label: AppStrings.passwordLabel,
          hint: AppStrings.passwordHint,
          prefixIcon: Icons.remove_red_eye_rounded,
          isPassword: true,
          isRequired: true,
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
