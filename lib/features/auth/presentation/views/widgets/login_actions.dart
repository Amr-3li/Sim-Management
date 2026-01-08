import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_management_task/core/services/sharedpreference_singelton.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';
import 'package:sim_management_task/features/auth/presentation/views/widgets/finger_print.dart';
import 'package:sim_management_task/features/sim_management/presentation/views/pages/sim_management_page.dart';

class LoginActions extends StatelessWidget {
  const LoginActions({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.formState,
  });

  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formState;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              AppStrings.forgetPassword,
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Login Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => _handleLogin(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppStrings.login,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Divider with text
        const Row(
          children: [
            Expanded(child: Divider(color: AppColors.grey300, thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppStrings.orSignInWith,
                style: TextStyle(color: AppColors.grey500, fontSize: 13),
              ),
            ),
            Expanded(child: Divider(color: AppColors.grey300, thickness: 1)),
          ],
        ),
        const SizedBox(height: 24),
        // Fingerprint Button
        const FingerPrintLogin(),
      ],
    );
  }

  void _handleLogin(BuildContext context) async {
    if (!formState.currentState!.validate()) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.loggingIn),
        duration: Duration(seconds: 2),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    context.go(SimManagementPage.routeName);
    SharedPreferenceSingelton.setBool('islogedin', true);
  }
}
