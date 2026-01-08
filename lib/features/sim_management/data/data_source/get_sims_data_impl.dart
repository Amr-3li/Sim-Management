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

    try {
      bool hasSimCard = await SimReader.hasSimCard();

      if (!hasSimCard) {
        return [];
      }
      List<SimInfo> allSimCards = await SimReader.getAllSimInfo();
      print("=========================// ${allSimCards[0].toString()}");
      return allSimCards
          .map(
            (sim) => SimModel(
              id: sim.simSlotIndex!,
              phoneNumber: sim.carrierName == "vodafone"
                  ? "010********"
                  : "012********",
              provider: sim.carrierName!,
              simStatus: SimStatus.active,
              connectionStatus: ConnectionStatus.connected,
              signalStrength: 4,
            ),
          )
          .toList();
    } catch (e) {
      throw SimFailure("Error reading SIM info: $e");
    }
  }
}
