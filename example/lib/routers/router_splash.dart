import 'package:firefly_example/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firefly/ff_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashRouter extends StatefulWidget {
  const SplashRouter({Key? key}) : super(key: key);

  @override
  _SplashRouterState createState() => _SplashRouterState();

}

class _SplashRouterState extends State<SplashRouter> {

  _loadSplash() async {
    YHCSplashManager.loadSplash(adSlotId: Configuration.splashAdSlotId, priceFloor: 1).then((
        value) {
      Fluttertoast.showToast(
          msg: value ? "获取开屏物料成功" : "获取开屏物料失败");
    });
  }

  Future<bool> _isAdReady() async {
    bool isAdReady = await YHCSplashManager.isAdReady();
    Fluttertoast.showToast(
        msg: isAdReady ? "物料已准备完成" : "物料未准备完成");
    return isAdReady;
  }

  _showSplash() async {
    var isAdReady = await _isAdReady();
    if(isAdReady) {
      Navigator.pushNamed(context, "/splashView");
    }
  }

  _getAdSlotAd() async {
    YHCSplashManager.getAdSlotAd().then((value) {
      Fluttertoast.showToast(msg: value);
    });
  }

  _getEcpm() async {
    YHCSplashManager.getEcpm().then((value) {
      Fluttertoast.showToast(msg: "ecpm = ${value}");
    });
  }

  _getMaterialType() {
    YHCSplashManager.getMaterialType().then((value) {
      Fluttertoast.showToast(msg: "物料类型 = ${value}");
    });
  }

  _destroy() {
    YHCSplashManager.destroy().then((value) {
      Fluttertoast.showToast(msg: value ? "销毁成功" : "销毁失败");
    });
  }

  _win() {
    int price = 12;
    Map<String, dynamic> map = {
      "adn": 1,
      "ad_t": 1,
      "ad_time": DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "bid_t": 1,
      "reason": "竞价成功",
      "is_s": 1,
      "is_c": 1,
    };
    YHCSplashManager.win(price: price, map: map);
  }

  _loss() {
    int price = 12;
    Map<String, dynamic> map = {
      "adn": 1,
      "ad_t": 1,
      "ad_time": DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "bid_t": 1,
      "reason": "竞价失败",
      "is_s": 0,
      "is_c": 1,
    };
    YHCSplashManager.loss(price: price, map: map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("开屏"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
            crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
            children: [
              ElevatedButton(
                onPressed: () {
                  _loadSplash();
                },
                child: Text('获取开屏物料'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _isAdReady();
                },
                child: Text('物料是否准备完成'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _showSplash();
                },
                child: Text('展示广告'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _getAdSlotAd();
                },
                child: Text('获取代码位'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _getEcpm();
                },
                child: Text('获取ecpm'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _getMaterialType();
                },
                child: Text('获取物料类型'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _win();
                },
                child: Text('竞胜回传'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _loss();
                },
                child: Text('竞败回传'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _destroy();
                },
                child: Text('销毁'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}