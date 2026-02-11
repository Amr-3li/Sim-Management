import 'package:permission_handler/permission_handler.dart';
import 'package:sim_management_task/core/utils/failure.dart';
import 'package:sim_management_task/features/sim_management/data/data_source/get_sims_data.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';
import 'package:sim_reader/sim_reader.dart';

class GetSimsDataImpl implements GetSimsData {
  @override
  Future<List<SimModel>> getSims() async {
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      throw PermissionFailure("Permission not granted");
    }

    final hasSim = await SimReader.hasSimCard();
    if (!hasSim) return [];

    final sims = await SimReader.getAllSimInfo();

    return sims.map((sim) {
      return SimModel(
        id: sim.simSlotIndex!,
        phoneNumber: "01*********",
        provider: sim.carrierName ?? "Unknown",
        simStatus: SimStatus.active,
        connectionStatus: ConnectionStatus.connected,
        signalStrength: 4,
      );
    }).toList();
  }
}
