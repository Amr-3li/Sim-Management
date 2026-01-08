import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';
import 'package:sim_management_task/features/auth/presentation/cubit/log_in_biometric_cubit_cubit.dart';
import 'package:sim_management_task/features/sim_management/presentation/views/pages/sim_management_page.dart';

class FingerPrintLogin extends StatelessWidget {
  const FingerPrintLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInBiometricCubitCubit, LogInBiometricCubitState>(
      listener: (context, state) {
        if (state is LogInBiometricCubitSuccess &&
            state.biometric.isAuthenticated) {
          context.go(SimManagementPage.routeName);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.loginSuccessful)),
          );
        }
      },
      builder: (context, state) {
        if (state is LogInBiometricCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return _buildFingerprintButton(context);
      },
    );
  }

  Widget _buildFingerprintButton(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.grey300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {
          context.read<LogInBiometricCubitCubit>().logInBiometric();
        },
        icon: const Icon(Icons.fingerprint, color: AppColors.blue, size: 32),
      ),
    );
  }
}
