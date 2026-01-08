import 'package:dartz/dartz.dart';
import 'package:sim_management_task/core/utils/failure.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';
import 'package:sim_management_task/features/sim_management/domain/repo/get_sim_data_repo.dart';

class GetSimDataUseCase {
  final GetSimDataRepo getSimDataRepo;

  GetSimDataUseCase(this.getSimDataRepo);

  Future<Either<Failure, List<SimModel>>> call() async {
    return await getSimDataRepo.getSims();
  }
}
