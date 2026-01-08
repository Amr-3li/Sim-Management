import 'package:flutter/material.dart';
import 'package:sim_management_task/core/utils/app_color.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final bool isSuccess;

  const StatusBadge({super.key, required this.label, this.isSuccess = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSuccess ? AppColors.success : AppColors.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSuccess ? AppColors.successText : AppColors.errorText,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
