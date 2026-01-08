import 'package:dartz/dartz.dart';
import 'package:sim_management_task/features/auth/data/data_source/log_in_with_biometric.dart';
import 'package:sim_management_task/features/auth/data/model/biometric.dart';
import 'package:sim_management_task/features/auth/domain/rebo/log_in_biometric_rebo.dart';

class LogInBiometricReboImbl implements LogInBiometricRebo {
  final LogInWithBiometric logInWithBiometric;
  LogInBiometricReboImbl({required this.logInWithBiometric});
  @override
  Future<Either<String, Biometric>> logInBiometric() async {
    try {
      final result = await logInWithBiometric.logInWithBiometric();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
