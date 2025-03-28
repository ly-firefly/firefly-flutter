import 'package:firefly_example/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firefly/ff_splash.dart';
import 'package:flutter/services.dart';
import 'package:firefly/ff_sdk_const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashRouter extends StatefulWidget {
  const SplashRouter({Key? key}) : super(key: key);

  @override
  _SplashRouterState createState() => _SplashRouterState();

}

class _SplashRouterState extends State<SplashRouter> {
  final TextEditingController _controllerSlotId = TextEditingController();
  final TextEditingController _controllerPriceFloor = TextEditingController();


  _loadSplash() async {
    int priceFloorH = _getPriceFloor();
    var slotId = _getSlotId();
    if(slotId == null || slotId.isEmpty) {
      slotId = Configuration.splashAdSlotId;
    }
    YHCSplashManager.loadSplash(adSlotId: slotId, priceFloor: priceFloorH).then((
        value) {
      var resultCode = value.resultCode;
      var resultMsg = value.resultMsg;
      print(resultCode == 0 ? "获取开屏物料成功" : "获取开屏物料失败 resultCode = ${resultCode}, resultMsg = ${resultMsg}");
      Fluttertoast.showToast(
          msg: resultCode == 0 ? "获取开屏物料成功" : "获取开屏物料失败 resultCode = ${resultCode}, resultMsg = ${resultMsg}");
    });
  }

  Future<bool> _isAdReady() async {
    bool isAdReady = await YHCSplashManager.isAdReady();
    print(isAdReady ? "物料已准备完成" : "物料未准备完成");
    Fluttertoast.showToast(
        msg: isAdReady ? "物料已准备完成" : "物料未准备完成");
    return isAdReady;
  }

  _showSplash() async {
    Navigator.pushNamed(context, "/splashView");
  }

  _getAdSlotAd() async {
    YHCSplashManager.getAdSlotAd().then((value) {
      print("代码位Id = ${value}");
      Fluttertoast.showToast(msg: "代码位Id = ${value}");
    });
  }

  _getRequestId() async {
    YHCSplashManager.getRequestId().then((value) {
      print("RequestId = ${value}");
      Fluttertoast.showToast(msg: "RequestId = ${value}");
    });
  }

  _getEcpm() async {
    YHCSplashManager.getEcpm().then((value) {
      print("ecpm = ${value}");
      Fluttertoast.showToast(msg: "ecpm = ${value}");
    });
  }

  _getMaterialType() {
    YHCSplashManager.getMaterialType().then((value) {
      print("物料类型 = ${value}");
      Fluttertoast.showToast(msg: "物料类型 = ${value}");
    });
  }

  _destroy() {
    YHCSplashManager.destroy().then((value) {
      print(value ? "销毁成功" : "销毁失败");
      Fluttertoast.showToast(msg: value ? "销毁成功" : "销毁失败");
    });
  }

  _win() {
    int price = 12;
    Map<String, dynamic> map = {
      BiddingNoticeKey.KEY_ADN: 1,
      BiddingNoticeKey.KEY_AD_MATERIAL: 1,
      BiddingNoticeKey.KEY_AD_TIME: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      BiddingNoticeKey.KEY_BID_TYPE: 1,
    };
    YHCSplashManager.win(price: price, map: map);
  }

  _loss() {
    int price = 12;
    Map<String, dynamic> map = {
      BiddingNoticeKey.KEY_ADN: 1,
      BiddingNoticeKey.KEY_AD_MATERIAL: 1,
      BiddingNoticeKey.KEY_AD_TIME: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      BiddingNoticeKey.KEY_BID_TYPE: 1,
      BiddingNoticeKey.KEY_LOSS_REASON: "竞价失败",
      BiddingNoticeKey.KEY_IS_SHOW: 0,
      BiddingNoticeKey.KEY_IS_CLICK: 1,
    };
    YHCSplashManager.loss(price: price, map: map);
  }

  String _getSlotId() {
    String inputText = _controllerSlotId.text;
    // 你也可以弹个 Toast 或 Dialog
    return inputText;
  }

  int _getPriceFloor() {
    String inputText = _controllerPriceFloor.text;
    // 你也可以弹个 Toast 或 Dialog
    int priceFloor = 0;
    if(inputText.isNotEmpty) {
      priceFloor = int.parse(inputText);
    }
    return priceFloor;
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
            crossAxisAlignment: CrossAxisAlignment.center, // 水平居中
            children: [
              TextField(
                controller: _controllerSlotId,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                    labelText: Configuration.splashAdSlotId,
                    border: OutlineInputBorder(),
                    hintText: "输入代码位"
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _controllerPriceFloor,
                enableInteractiveSelection: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "输入底价"
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _loadSplash();
                },
                child: Text('获取开屏物料'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _isAdReady();
                },
                child: Text('物料是否准备完成'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _showSplash();
                },
                child: Text('展示广告'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _getAdSlotAd();
                },
                child: Text('获取代码位'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _getRequestId();
                },
                child: Text('获取requestId'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _getEcpm();
                },
                child: Text('获取ecpm'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _getMaterialType();
                },
                child: Text('获取物料类型'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _win();
                },
                child: Text('竞胜回传'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _loss();
                },
                child: Text('竞败回传'),
              ),
              SizedBox(height: 5),
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