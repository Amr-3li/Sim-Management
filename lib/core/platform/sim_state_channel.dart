import 'package:flutter/services.dart';

class SimStateChannel {
  static const EventChannel _channel = EventChannel('sim_state_events');

  static Stream<void> get stream =>
      _channel.receiveBroadcastStream().map((_) {});
}
