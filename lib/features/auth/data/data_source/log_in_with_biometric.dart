import 'package:local_auth/local_auth.dart';
import 'package:sim_management_task/features/auth/data/model/biometric.dart';

abstract class LogInWithBiometric {
  Future<Biometric> logInWithBiometric();
}
