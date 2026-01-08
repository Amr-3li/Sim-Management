import 'package:dartz/dartz.dart';
import 'package:sim_management_task/core/utils/failure.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';

abstract class GetSimDataRepo {
  Future<Either<Failure, List<SimModel>>> getSims();
}
