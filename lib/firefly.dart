
import 'dart:async';

import 'package:flutter/services.dart';

class Firefly {
  static const MethodChannel channel = MethodChannel('firefly');

  static Future<String?> get platformVersion async {
    final String? version = await channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
