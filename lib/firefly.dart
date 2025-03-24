
import 'dart:async';

import 'package:flutter/services.dart';

class Firefly {
  static const MethodChannel _channel = MethodChannel('firefly');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
