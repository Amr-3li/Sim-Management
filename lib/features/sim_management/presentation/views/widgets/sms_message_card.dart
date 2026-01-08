import 'package:flutter/material.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/core/utils/app_strings.dart';
import 'package:sim_management_task/features/sim_management/data/models/sms_model.dart';

class SmsMessageCard extends StatelessWidget {
  final SmsModel sms;

  const SmsMessageCard({super.key, required this.sms});

  @override
  Widget build(BuildContext context) {
    var children = [
      Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getIconBackgroundColor(),
              shape: BoxShape.circle,
            ),
            child: Icon(_getIconData(), color: _getIconColor(), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sms.sender,
                  style: const TextStyle(
                    color: AppColors.grey900,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  sms.timeAgo,
                  style: const TextStyle(
                    color: AppColors.grey500,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (sms.type != SmsType.unrecognized)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _getTypeBadgeBackground(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _getTypeLabel(),
                style: TextStyle(
                  color: _getTypeBadgeColor(),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (sms.type == SmsType.unrecognized)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                AppStrings.unrecognized,
                style: TextStyle(
                  color: AppColors.grey600,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sms.message,
              style: const TextStyle(
                color: AppColors.grey600,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            Divider(color: AppColors.grey400, thickness: 1),
            if (sms.amount != null || sms.balance != null) ...[
              const SizedBox(height: 12),
              Wrap(
                children: [
                  if (sms.amount != null) ...[
                    RichText(
                      text: TextSpan(
                        text: AppStrings.amount,
                        style: TextStyle(
                          color: AppColors.grey500,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '\$${sms.amount!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.grey900,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(width: 10),
                  if (sms.balance != null) ...[
                    RichText(
                      text: TextSpan(
                        text: AppStrings.balance,
                        style: TextStyle(
                          color: AppColors.grey500,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '\$${sms.balance!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.grey900,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
            if (sms.transactionId != null) ...[
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: AppStrings.txn,
                      style: const TextStyle(
                        color: AppColors.grey500,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${sms.transactionId}',
                          style: const TextStyle(
                            color: AppColors.grey900,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.grey400, thickness: 1),
                ],
              ),
            ],
          ],
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Icon(_getStatusIcon(), size: 16, color: _getStatusColor()),
          const SizedBox(width: 6),
          Text(
            _getStatusLabel(),
            style: TextStyle(
              color: _getStatusColor(),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: _getStatusBackgroundColor(),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _getStatusColor(), width: 1),
            ),
            child: Text(
              _getStatusLabel(),
              style: TextStyle(
                color: _getStatusColor(),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ];
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  IconData _getIconData() {
    if (sms.type == SmsType.unrecognized) {
      return Icons.info_outline;
    }
    return Icons.arrow_downward_sharp;
  }

  Color _getIconColor() {
    if (sms.type == SmsType.unrecognized) {
      return AppColors.grey600;
    }
    return const Color(0xFF10B981);
  }

  Color _getIconBackgroundColor() {
    if (sms.type == SmsType.unrecognized) {
      return AppColors.grey100;
    }
    return const Color(0xFFD1FAE5);
  }

  String _getTypeLabel() {
    switch (sms.type) {
      case SmsType.transferIn:
        return AppStrings.transferIn;
      case SmsType.transferOut:
        return AppStrings.transferOut;
      case SmsType.unrecognized:
        return AppStrings.unrecognized;
    }
  }

  Color _getTypeBadgeColor() {
    switch (sms.type) {
      case SmsType.transferIn:
        return const Color(0xFF059669);
      case SmsType.transferOut:
        return const Color(0xFFDC2626);
      case SmsType.unrecognized:
        return AppColors.grey600;
    }
  }

  Color _getTypeBadgeBackground() {
    switch (sms.type) {
      case SmsType.transferIn:
        return const Color(0xFFD1FAE5);
      case SmsType.transferOut:
        return const Color(0xFFFEE2E2);
      case SmsType.unrecognized:
        return AppColors.grey100;
    }
  }

  IconData _getStatusIcon() {
    switch (sms.status) {
      case SmsStatus.processed:
        return Icons.check_circle_outline_outlined;
      case SmsStatus.synced:
        return Icons.sync;
      case SmsStatus.failed:
        return Icons.cancel_outlined;
    }
  }

  Color _getStatusColor() {
    switch (sms.status) {
      case SmsStatus.processed:
        return const Color(0xFF059669);
      case SmsStatus.synced:
        return const Color(0xFF10B981);
      case SmsStatus.failed:
        return const Color(0xFFDC2626);
    }
  }

  Color _getStatusBackgroundColor() {
    switch (sms.status) {
      case SmsStatus.processed:
        return const Color(0xFFD1FAE5);
      case SmsStatus.synced:
        return const Color(0xFFD1FAE5);
      case SmsStatus.failed:
        return const Color(0xFFFEE2E2);
    }
  }

  String _getStatusLabel() {
    switch (sms.status) {
      case SmsStatus.processed:
        return AppStrings.processed;
      case SmsStatus.synced:
        return AppStrings.synced;
      case SmsStatus.failed:
        return AppStrings.failed;
    }
  }
}
