import 'package:dartz/dartz.dart';
import 'package:sim_management_task/features/auth/data/model/biometric.dart';
import 'package:sim_management_task/features/auth/domain/rebo/log_in_biometric_rebo.dart';

class LogInBiometricUseCase {
  final LogInBiometricRebo logInBiometricRebo;
  LogInBiometricUseCase({required this.logInBiometricRebo});
  Future<Either<String, Biometric>> call() async {
    return await logInBiometricRebo.logInBiometric();
  }
}
