// ignore_for_file: invalid_use_of_protected_member, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_management_task/core/services/sharedpreference_singelton.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';
import 'package:sim_management_task/core/widgets/custom_app_bar.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';
import 'package:sim_management_task/features/sim_management/presentation/cubits/get_sim_data/get_sim_data_cubit.dart';
import '../widgets/sim_card_widget.dart';
import '../widgets/quick_tips_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/loading_state_widget.dart';

class SimManagementPage extends StatefulWidget {
  const SimManagementPage({super.key});

  static const String routeName = '/sim_management';

  @override
  State<SimManagementPage> createState() => _SimManagementPageState();
}

class _SimManagementPageState extends State<SimManagementPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetSimDataCubit>()
      ..getSims()
      ..listenSimChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: AppStrings.simManagement,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: const Text(AppStrings.logout),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                SharedPreferenceSingelton.setBool('islogedin', false);
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _handleRefresh,
                      icon: const Icon(Icons.sync, size: 20),
                      label: const Text(AppStrings.refresh),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined, size: 20),
                      label: const Text(AppStrings.settings),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: BlocBuilder<GetSimDataCubit, GetSimDataState>(
                  builder: (context, state) {
                    if (state is GetSimDataLoading) {
                      return const LoadingStateWidget();
                    } else if (state is GetSimDataSuccess &&
                        state.sims.isNotEmpty) {
                      return _buildSimCardsList(state.sims);
                    } else if (state is GetSimDataSuccess &&
                        state.sims.isEmpty) {
                      return EmptyStateWidget(
                        icon: Icons.sim_card_outlined,
                        iconColor: AppColors.grey600,
                        iconBackgroundColor: AppColors.grey100,
                        title: AppStrings.noSimCardsDetected,
                        description: AppStrings
                            .pleaseInsertASimCardIntoYourDeviceToContinueMakeSureTheSimCardIsProperlySeatedInTheSimTray,
                        buttonText: AppStrings.retry,
                        onButtonPressed: _handleRetry,
                      );
                    } else {
                      return EmptyStateWidget(
                        icon: Icons.phone_android_outlined,
                        iconColor: AppColors.grey600,
                        iconBackgroundColor: AppColors.grey100,
                        title: AppStrings.noSimCardsDetected,
                        description: AppStrings
                            .pleaseInsertASimCardIntoYourDeviceToContinueMakeSureTheSimCardIsProperlySeatedInTheSimTray,
                        buttonText: AppStrings.retry,
                        onButtonPressed: _handleRetry,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimCardsList(List<SimModel> sims) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          ...sims.map(
            (sim) => SimCardWidget(
              sim: sim,
              onButtonPressed: () {
                _handleSimAction(sim);
              },
            ),
          ),
          // Quick tips
          const QuickTipsCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _handleRefresh() {
    context.read<GetSimDataCubit>().getSims();
  }

  void _handleRetry() {
    context.read<GetSimDataCubit>().getSims();
  }

  void _handleSimAction(SimModel sim) {
    final action = sim.isConnected
        ? AppStrings.syncing
        : AppStrings.checkingConnectionFor;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action ${sim.id}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
