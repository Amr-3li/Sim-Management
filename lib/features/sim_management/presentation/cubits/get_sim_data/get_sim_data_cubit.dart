import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sim_management_task/core/utils/failure.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';
import 'package:sim_management_task/features/sim_management/domain/use_case/get_sim_data_use_case.dart';
import 'package:sim_management_task/features/sim_management/domain/use_case/listen_sim_changes.dart';

part 'get_sim_data_state.dart';

class GetSimDataCubit extends Cubit<GetSimDataState> {
  GetSimDataCubit(this.getSimDataUseCase, {required this.listenSimChanges})
    : super(GetSimDataInitial());
  GetSimDataUseCase getSimDataUseCase;
  final ListenSimChanges listenSimChanges;
  StreamSubscription? _simSubscription;

  Future<void> getSims() async {
    emit(GetSimDataLoading());
    final result = await getSimDataUseCase.call();
    result.fold(
      (failure) => emit(GetSimDataFailure(failure: failure)),
      (sims) => emit(GetSimDataSuccess(sims: sims)),
    );
  }

  void startListening() {
    _simSubscription = listenSimChanges().listen((_) {
      getSims(); // reload on SIM change
    });
  }

  @override
  Future<void> close() {
    _simSubscription?.cancel();
    return super.close();
  }
}
