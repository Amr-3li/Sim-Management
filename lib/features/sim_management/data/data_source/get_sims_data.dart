import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';

abstract class GetSimsData {
  Future<List<SimModel>> getSims();
}
