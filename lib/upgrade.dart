import 'dart:async';

import 'package:flutter/services.dart';

class Upgrade {
  static const MethodChannel _channel =
      const MethodChannel('upgrade');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
