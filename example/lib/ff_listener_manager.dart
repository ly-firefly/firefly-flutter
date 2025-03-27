import 'package:firefly/ff_listener.dart';
import 'package:firefly/ff_splash_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'global_keys.dart';

final ListenerManager = ListenerTool();

class ListenerTool {
  splashListen(BuildContext context) {
    YHCListenerManager.splashEventHandler.listen((event) {
      switch (event.splashStatus) {
        case AdStatus.onAdShow:
          print("广告开始展示");
          Fluttertoast.showToast(msg: "广告开始展示");
          break;
        case AdStatus.onAdShowError:
          print("广告加载出错 errorMsg = ${event.errorMsg} , errorCode = ${event.errorCode}");
          Fluttertoast.showToast(msg: "广告加载出错");
          var currentContext = navigatorKey.currentContext;
          if(currentContext != null) {
            Navigator.of(currentContext).pop();
          }
          break;
        case AdStatus.onAdClicked:
          print("广告被点击");
          Fluttertoast.showToast(msg: "广告被点击");
          break;
        case AdStatus.onSkippedAd:
          print("广告跳过被点击");
          Fluttertoast.showToast(msg: "广告跳过被点击");
          var currentContext = navigatorKey.currentContext;
          if(currentContext != null) {
            Navigator.of(currentContext).pop();
          }
          break;
        case AdStatus.onAdShowEnd:
          print("广告播放结束");
          Fluttertoast.showToast(msg: "广告播放结束");
          var currentContext = navigatorKey.currentContext;
          if(currentContext != null) {
            Navigator.of(currentContext).pop();
          }
          break;
        case AdStatus.onAdUnknown:
          print("未知回调");
          Fluttertoast.showToast(msg: "未知回调");
          break;
      }
    });
  }
}