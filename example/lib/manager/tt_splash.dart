import 'package:firefly/ff_platformview/ff_splash_platform_widget.dart';
import 'package:firefly/ff_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // 销毁当前开屏广告
    _destroy();
  }

  _destroy() {
    YHCSplashManager.destroy().then((value) {
      Fluttertoast.showToast(msg: value ? "销毁成功" : "销毁失败");
    });
  }

  _getSplashView() {
    return PlatformSplashWidget();
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