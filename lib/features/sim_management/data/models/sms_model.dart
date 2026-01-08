enum SmsStatus { processed, synced, failed }

enum SmsType { transferIn, transferOut, unrecognized }

class SmsModel {
  final String id;
  final String sender;
  final String message;
  final String timeAgo;
  final SmsStatus status;
  final SmsType type;
  final double? amount;
  final double? balance;
  final String? transactionId;

  const SmsModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.timeAgo,
    required this.status,
    required this.type,
    this.amount,
    this.balance,
    this.transactionId,
  });

  bool get isProcessed => status == SmsStatus.processed;
  bool get isSynced => status == SmsStatus.synced;
  bool get isFailed => status == SmsStatus.failed;
}

class SmsStats {
  final int total;
  final int synced;
  final int pending;
  final int failed;

  const SmsStats({
    required this.total,
    required this.synced,
    required this.pending,
    required this.failed,
  });
}
