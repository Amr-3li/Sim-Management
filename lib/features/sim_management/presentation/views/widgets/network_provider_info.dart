import 'package:flutter/material.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';

class NetworkProviderInfo extends StatelessWidget {
  final String provider;
  final int signalStrength;

  const NetworkProviderInfo({
    super.key,
    required this.provider,
    required this.signalStrength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Provider icon
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.wifi, color: AppColors.white, size: 24),
        ),
        const SizedBox(width: 12),
        // Provider details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.networkProvider,
                style: TextStyle(
                  color: AppColors.grey500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provider,
                style: const TextStyle(
                  color: AppColors.grey900,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        // Signal strength
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _SignalStrengthIndicator(strength: signalStrength),
            const SizedBox(height: 2),
            const Text(
              AppStrings.signal,
              style: TextStyle(
                color: AppColors.grey500,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SignalStrengthIndicator extends StatelessWidget {
  final int strength;

  const _SignalStrengthIndicator({required this.strength});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (index) {
        final isActive = index < strength;
        return Container(
          width: 4,
          height: 4.0 + (index * 3.0),
          margin: const EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
            color: isActive
                ? const Color.fromARGB(255, 32, 226, 119)
                : AppColors.grey300,
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }),
    );
  }
}
