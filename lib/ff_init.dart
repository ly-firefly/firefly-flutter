
import 'dart:io';

import 'package:firefly/firefly.dart';

final FFInitManger = FFInit();

class FFInit {
  /*
    初始化
   */
  Future<bool> initFireFlySDK({
    required String appId,
    required bool enableDebug,
    String? appName,
    bool isCanUsePhoneState = true,
    String? oaid,
    bool isCanUseAndroidId = true,

  }) async {
    var args = {
      "appId": appId,
      "appName": (appName != null && appName.isNotEmpty) ? appName : "",
      "enableDebug": enableDebug,
    };
    if(Platform.isAndroid) {
      args["isCanUsePhoneState"] = isCanUsePhoneState;
      args["oaid"] = (oaid != null && oaid.isNotEmpty) ? oaid : "";
      args["isCanUseAndroidId"] = isCanUseAndroidId;
    }
    return await Firefly.channel.invokeMethod("initFireFlySDK", args);
  }

  Future<String> getAppId() async {
    String? appId = await Firefly.channel.invokeMethod("getAppId", {});
    return appId ?? '';
  }

  Future<String> getSDKVersion() async {
    String? sdkVersion = await Firefly.channel.invokeMethod("getSDKVersion", {});
    return sdkVersion ?? '';
  }

  Future<String> getAppName() async {
    String? appName = await Firefly.channel.invokeMethod("getAppName", {});
    return appName ?? '';
  }
}

