import 'package:firefly/ff_platformview/ff_splash_platform_widget.dart';
import 'package:firefly/ff_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../configuration.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool flag = false;

  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  @override
  void dispose() {
    // 销毁当前开屏广告
    _destroy();
    super.dispose();
  }
  // 销毁开屏
  _destroy() {
    YHCSplashManager.destroy().then((value) {
      Fluttertoast.showToast(msg: value ? "销毁成功" : "销毁失败");
    });
  }
  // 请求开屏物料
  _loadSplash() async {
    await YHCSplashManager.loadSplash(adSlotId: Configuration.splashAdSlotId);
    _isAdReady();
  }
  // 是否准备完成
  _isAdReady() async {
    YHCSplashManager.isAdReady().then((value) {
      setState(() {
        flag = value;
      });
    });
  }
  // 展示开屏View
  _getSplashView() {
    if(flag) {
      return PlatformSplashWidget();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 垂直居中
          crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: _getSplashView(),
                ))
          ],
        ),
      ),
    );
  }

}