import 'package:local_auth/local_auth.dart';
import 'package:sim_management_task/core/services/sharedpreference_singelton.dart';
import 'package:sim_management_task/features/auth/data/data_source/log_in_with_biometric.dart';
import 'package:sim_management_task/features/auth/data/model/biometric.dart';

class LogInWithBiometricImpl implements LogInWithBiometric {
  LogInWithBiometricImpl();
  final LocalAuthentication localAuthentication = LocalAuthentication();
  @override
  Future<Biometric> logInWithBiometric() async {
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    if (!canCheckBiometrics) {
      return Biometric(isAuthenticated: false);
    }
    bool auth = await localAuthentication.authenticate(
      localizedReason: 'Please authenticate to log in',
      biometricOnly: true,
    );
    SharedPreferenceSingelton.setBool('islogedin', true);
    return Biometric(isAuthenticated: auth);
  }
}
