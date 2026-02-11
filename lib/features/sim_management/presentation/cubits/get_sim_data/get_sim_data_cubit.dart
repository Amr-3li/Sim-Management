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

  final GetSimDataUseCase getSimDataUseCase;
  final ListenSimChanges listenSimChanges;

  StreamSubscription? _simSubscription;
  Timer? _debounce;

  Future<void> getSims({bool isBackgroundUpdate = false}) async {
    if (!isBackgroundUpdate) {
      emit(GetSimDataLoading());
    }

    final result = await getSimDataUseCase();

    result.fold((failure) => emit(GetSimDataFailure(failure: failure)), (
      newSims,
    ) {
      if (state is GetSimDataSuccess) {
        final oldSims = (state as GetSimDataSuccess).sims;

        final oldIds = oldSims.map((e) => e.id).toSet();
        final newIds = newSims.map((e) => e.id).toSet();

        if (oldIds.length == newIds.length && oldIds.containsAll(newIds)) {
          return;
        }
      }

      emit(GetSimDataSuccess(sims: newSims));
    });
  }

  void startListening() {
    _simSubscription = listenSimChanges().listen((_) {
      _debounce?.cancel();
      _debounce = Timer(
        const Duration(milliseconds: 600),
        () => getSims(isBackgroundUpdate: true),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _simSubscription?.cancel();
    return super.close();
  }
}
