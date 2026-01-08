import 'package:sim_management_task/core/platform/sim_state_channel.dart';

class ListenSimChanges {
  Stream<void> call() {
    return SimStateChannel.stream;
  }
}
