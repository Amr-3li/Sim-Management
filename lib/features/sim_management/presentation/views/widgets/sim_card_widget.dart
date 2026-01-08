import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';
import 'package:sim_management_task/features/sim_management/presentation/views/pages/sync_sms_page.dart';
import 'network_provider_info.dart';
import 'status_badge.dart';

class SimCardWidget extends StatelessWidget {
  final SimModel sim;
  final VoidCallback onButtonPressed;

  const SimCardWidget({
    super.key,
    required this.sim,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(SyncSmsPage.routeName, extra: "${sim.id + 1}");
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SIM ${sim.id + 1}",
                    style: const TextStyle(
                      color: AppColors.grey900,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  StatusBadge(
                    label: sim.isActive
                        ? AppStrings.active
                        : AppStrings.inactive,
                    isSuccess: sim.isActive,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Phone number
              Text(
                sim.phoneNumber,
                style: const TextStyle(
                  color: AppColors.grey500,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: AppColors.grey300, thickness: 1),
              const SizedBox(height: 20),
              NetworkProviderInfo(
                provider: sim.provider,
                signalStrength: sim.signalStrength,
              ),

              const SizedBox(height: 20),
              const Divider(color: AppColors.grey300, thickness: 1),
              Row(
                children: [
                  Icon(
                    sim.isConnected ? Icons.check_circle : Icons.cancel,
                    size: 16,
                    color: sim.isConnected
                        ? AppColors.successText
                        : AppColors.errorText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppStrings.systemStatus,
                    style: TextStyle(
                      color: AppColors.grey600,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: sim.isConnected
                            ? AppColors.infoText
                            : AppColors.errorText,
                      ),
                      color: sim.isConnected
                          ? AppColors.infoBackground
                          : AppColors.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      sim.isConnected
                          ? AppStrings.connected
                          : AppStrings.notConnected,
                      style: TextStyle(
                        color: sim.isConnected
                            ? AppColors.infoText
                            : AppColors.errorText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  child: Text(
                    sim.isConnected
                        ? AppStrings.syncSim
                        : AppStrings.checkConnection,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
