import 'package:dartz/dartz.dart';
import 'package:sim_management_task/features/auth/data/model/biometric.dart';

abstract class LogInBiometricRebo {
  Future<Either<String, Biometric>> logInBiometric();
}
