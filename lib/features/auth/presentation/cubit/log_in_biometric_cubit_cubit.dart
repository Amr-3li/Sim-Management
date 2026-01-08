import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sim_management_task/features/auth/data/model/biometric.dart';
import 'package:sim_management_task/features/auth/domain/use_case/log_in_biometric_use_case.dart';

part 'log_in_biometric_cubit_state.dart';

class LogInBiometricCubitCubit extends Cubit<LogInBiometricCubitState> {
  LogInBiometricCubitCubit({required this.logInBiometricUseCase})
    : super(LogInBiometricCubitInitial());
  final LogInBiometricUseCase logInBiometricUseCase;
  Future<void> logInBiometric() async {
    emit(LogInBiometricCubitLoading());
    final result = await logInBiometricUseCase.call();
    result.fold(
      (l) => emit(LogInBiometricCubitError(message: l)),
      (r) => emit(LogInBiometricCubitSuccess(biometric: r)),
    );
  }
}
