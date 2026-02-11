import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<PermissionStatus> requestSmsPermissions() async {
    final sms = await Permission.sms.request();
    final phone = await Permission.phone.request();

    if (sms.isGranted && phone.isGranted) {
      return PermissionStatus.granted;
    }

    if (sms.isPermanentlyDenied || phone.isPermanentlyDenied) {
      return PermissionStatus.permanentlyDenied;
    }

    return PermissionStatus.denied;
  }
}
