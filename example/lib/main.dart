import 'package:firefly_example/global_keys.dart';
import 'package:firefly_example/routers/Routers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firefly/ff_index.dart';

import 'configuration.dart';
import 'ff_listener_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInit = false;
  // 创建控制器
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setListen();
  }

  _initFireFlySDK() async {
    var appId = _getInputText();
    await FFInitManger.initFireFlySDK(
            appId: (appId == null || appId.isEmpty) ? Configuration.appId : appId,
            enableDebug: true,
            appName: "firefly flutter demo",
            isCanUsePhoneState: true,
            oaid: "test",
            isCanUseAndroidId: true)
        .then((value){
              setState(() {
                isInit = value;
              });
              print(value ? "初始化成功" : "初始化失败");
              Fluttertoast.showToast(msg: value ? "初始化成功" : "初始化失败");
            });
  }

  _getAppId() async {
    FFInitManger.getAppId().then((value) {
      print("appId = ${value}");
      Fluttertoast.showToast(msg: "appId = ${value}");
    });
  }

  _getAppName() async {
    FFInitManger.getAppName().then((value) {
      print("appName = ${value}");
      Fluttertoast.showToast(msg: "appName = ${value}");
    });
  }

  _getSDKVersion() async {
    FFInitManger.getSDKVersion().then((value) {
      print("sdk version = ${value}");
      Fluttertoast.showToast(msg: "sdk version = ${value}");
    });
  }

  _pushSplashRouter(BuildContext ctx) {
    if(isInit) {
      Navigator.pushNamed(ctx, "/splashRouter");
    } else {
      Fluttertoast.showToast(msg: "未初始化");
    }
  }

  _setListen() {
    // 监听开屏广告相关回调
    ListenerManager.splashListen(context);
  }

  String _getInputText() {
    String inputText = _controller.text;
    // 你也可以弹个 Toast 或 Dialog
    return inputText;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireFly SDK Demo',
      routes: anyYHCRouters,
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(title: Text('FireFly SDK Demo')),
        body: Builder(
          builder: (ctx) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
              children: [
                TextField(
                  controller: _controller, // 绑定控制器
                  enableInteractiveSelection: true, // 默认为 true，启用复制粘贴等
                  decoration: InputDecoration(
                    labelText: Configuration.appId,
                    border: OutlineInputBorder(),
                    hintText: "输入AppId"
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _initFireFlySDK();
                  },
                  child: Text('初始化'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _getAppId();
                  },
                  child: Text('getAppId'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _getAppName();
                  },
                  child: Text('getAppName'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _getSDKVersion();
                  },
                  child: Text('getSDKVersion'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _pushSplashRouter(ctx);
                  },
                  child: Text('开屏'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
