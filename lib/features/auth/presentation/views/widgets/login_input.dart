import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: AppStrings.phoneNumberLabel,
                style: const TextStyle(
                  color: AppColors.grey900,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            IntlPhoneField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.grey300,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.grey300,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.blue, width: 2),
                ),
              ),
              initialCountryCode: 'IN',
            ),
          ],
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
