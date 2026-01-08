enum SimStatus { active, notConnected }

enum ConnectionStatus { connected, notConnected }

enum SimDataState {
  loading,
  permissionRequired,
  noSimDetected,
  simCardsAvailable,
}

class SimModel {
  final int id;
  final String phoneNumber;
  final String provider;
  final SimStatus simStatus;
  final ConnectionStatus connectionStatus;
  final int signalStrength;

  const SimModel({
    required this.id,
    required this.phoneNumber,
    required this.provider,
    required this.simStatus,
    required this.connectionStatus,
    required this.signalStrength,
  });

  bool get isConnected => connectionStatus == ConnectionStatus.connected;
  bool get isActive => simStatus == SimStatus.active;
}
