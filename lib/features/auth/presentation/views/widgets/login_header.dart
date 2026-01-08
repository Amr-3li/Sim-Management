import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_images.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildShieldIcon(),
        const SizedBox(height: 24),
        Text(
          AppStrings.agentLogin,
          style: TextStyle(
            color: AppColors.grey900,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          AppStrings.secureAccessToYourWalletSystem,
          style: TextStyle(
            color: AppColors.grey500,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildShieldIcon() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SvgPicture.asset(
        AppImages.loginIcon,
        color: AppColors.blue,
        width: 32,
        height: 32,
      ),
    );
  }
}
