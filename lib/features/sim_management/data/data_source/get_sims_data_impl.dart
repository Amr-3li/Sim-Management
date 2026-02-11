import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_management_task/core/utils/failure.dart';
import 'package:sim_management_task/features/sim_management/data/data_source/get_sims_data.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';

class GetSimsDataImpl implements GetSimsData {
  static const MethodChannel _channel = MethodChannel('sim_data_channel');
  @override
  Future<List<SimModel>> getSims() async {
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      throw PermissionFailure("Permission not granted");
    }
    try {
      final List<dynamic>? result = await _channel.invokeMethod(
        'getAllSimData',
      );
      print(result);
      if (result != null) {
        return result.map((sim) {
          return SimModel(
            id: sim['subscriptionId'],
            phoneNumber: sim['number'] == ""
                ? "can't get number"
                : sim['number'],
            provider: sim['carrierName'] == ""
                ? "can't get provider"
                : sim['carrierName'],
            simStatus: SimStatus.active,
            connectionStatus: ConnectionStatus.connected,
            signalStrength: 4,
          );
        }).toList();
      }
    } on PlatformException catch (e) {
      print('❌ خطأ في جلب بيانات SIM: ${e.message}');
    }
    return [];
  }
}
