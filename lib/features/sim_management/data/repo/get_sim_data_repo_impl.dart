import 'package:dartz/dartz.dart';
import 'package:sim_management_task/core/utils/failure.dart';
import 'package:sim_management_task/features/sim_management/data/data_source/get_sims_data.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';
import 'package:sim_management_task/features/sim_management/domain/repo/get_sim_data_repo.dart';

class GetSimDataRepoImpl implements GetSimDataRepo {
  final GetSimsData simsData;

  GetSimDataRepoImpl(this.simsData);
  @override
  Future<Either<Failure, List<SimModel>>> getSims() async {
    try {
      final result = await simsData.getSims();
      return Right(result);
    } catch (e) {
      if (e is PermissionFailure) {
        return Left(PermissionFailure("Permission not granted"));
      } else {
        return Left(SimFailure(e.toString()));
      }
    }
  }
}
