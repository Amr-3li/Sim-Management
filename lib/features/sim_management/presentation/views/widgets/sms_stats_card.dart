import 'package:flutter/material.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/features/sim_management/data/models/sms_model.dart';

class SmsStatsCard extends StatelessWidget {
  final SmsStats stats;

  const SmsStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF06B6D4),
            iconBackground: const Color(0xFFCFFAFE),
            label: 'Total',
            value: stats.total.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatItem(
            icon: Icons.check_circle_outline,
            iconColor: const Color(0xFF10B981),
            iconBackground: const Color(0xFFD1FAE5),
            label: 'Synced',
            value: stats.synced.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatItem(
            icon: Icons.access_time,
            iconColor: const Color(0xFFF59E0B),
            iconBackground: const Color(0xFFFEF3C7),
            label: 'Pending',
            value: stats.pending.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatItem(
            icon: Icons.cancel_outlined,
            iconColor: const Color(0xFFEF4444),
            iconBackground: const Color(0xFFFEE2E2),
            label: 'Failed',
            value: stats.failed.toString(),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.grey900,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.grey500,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
