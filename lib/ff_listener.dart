import 'dart:async';

import 'package:firefly/ff_splash_response.dart';
import 'package:firefly/firefly.dart';
import 'package:flutter/services.dart';


final YHCListenerManager = YHCListener();

class YHCListener {

  StreamController<YHCSplashResponse> _splashEventHandlerController = new StreamController();

  Stream<YHCSplashResponse> get splashEventHandler =>
      _splashEventHandlerController.stream;

  YHCListener() {
    Firefly.channel.setMethodCallHandler(_adMethodHandler);
  }

  Future _adMethodHandler(MethodCall methodCall) {
    try {
      if (methodCall.method == 'SplashCall') {
        var tempInterstitialResponse = YHCSplashResponse.withMap(methodCall.arguments);
        _splashEventHandlerController.add(tempInterstitialResponse);
      }
    } catch (e, stack) {
      print("YHCFlutterSDK error：" + e.toString());
      print("YHCFlutterSDK error stack：" + stack.toString());
    }
    return Future.value();
  }
}