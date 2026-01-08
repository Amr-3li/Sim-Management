import 'package:flutter/material.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';
import 'package:sim_management_task/core/widgets/custom_app_bar.dart';
import 'package:sim_management_task/features/sim_management/data/models/sms_model.dart';
import '../widgets/sms_stats_card.dart';
import '../widgets/sms_message_card.dart';
import '../widgets/info_banner.dart';

class SyncSmsPage extends StatefulWidget {
  final String simName;
  static const String routeName = '/sync_sms';

  const SyncSmsPage({super.key, this.simName = 'SIM 1'});

  @override
  State<SyncSmsPage> createState() => _SyncSmsPageState();
}

class _SyncSmsPageState extends State<SyncSmsPage> {
  final SmsStats _stats = const SmsStats(
    total: 8,
    synced: 4,
    pending: 2,
    failed: 2,
  );

  final List<SmsModel> _messages = const [
    SmsModel(
      id: '1',
      sender: 'BANK - ALERT',
      message:
          'Your account has been credited with \$250.00. Available balance \$1,450.50. R...',
      timeAgo: '2 min ago',
      status: SmsStatus.processed,
      type: SmsType.transferIn,
      amount: 250.00,
      balance: 1450.50,
      transactionId: 'TXN45046789',
    ),
    SmsModel(
      id: '2',
      sender: 'BANK - ALERT',
      message: 'Failed to process transaction. Please contact support...',
      timeAgo: '5 hours ago',
      status: SmsStatus.failed,
      type: SmsType.unrecognized,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Sync SMS',
        subtitle: widget.simName,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _handleRefresh,
                      icon: const Icon(Icons.sync_outlined, size: 20),
                      label: const Text(AppStrings.refresh),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _handleSyncAll,
                      icon: const Icon(Icons.sync, size: 20),
                      label: const Text(AppStrings.syncAll),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey300, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        size: 20,
                        color: AppColors.grey700,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      SmsStatsCard(stats: _stats),
                      const SizedBox(height: 16),
                      const InfoBanner(
                        title: AppStrings.autoSMSProcessing,
                        description: AppStrings
                            .transactionMessagesAreAutomaticallyDetectedClassifiedAndSyncedToTheAdminDashboardInRealTime,
                      ),
                      const SizedBox(height: 20),
                      ..._messages.map((sms) => SmsMessageCard(sms: sms)),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRefresh() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.refreshingSMS),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleSyncAll() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.syncingAllMessages),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
