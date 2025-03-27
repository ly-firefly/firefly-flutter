
import 'package:firefly/ff_client_bidding.dart';
import 'package:firefly/firefly.dart';
import 'package:firefly/tt_base_ad.dart';

final YHCSplashManager = YHCSplash();

class YHCSplash implements YHCClientBidding, YHCIBaseAd {

  Future<bool> loadSplash({
    required String adSlotId,
    int? priceFloor
  }) async {
    var args = {
      "adSlotId": adSlotId,
      "priceFloor": (priceFloor != null) ? priceFloor : 0,
    };
    return await Firefly.channel.invokeMethod("loadSplash", args);
  }

  @override
  Future<bool> isAdReady() async {
    return await Firefly.channel.invokeMethod("splashReady", {});
  }

  @override
  Future<String> getAdSlotAd() async {
    return await Firefly.channel.invokeMethod("getSplashAdSlotAd", {});
  }

  @override
  Future<int> getMaterialType() async {
    return await Firefly.channel.invokeMethod("getSplashMaterialType", {});
  }

  @override
  Future<int> getEcpm() async {
    return await Firefly.channel.invokeMethod("getSplashEcpm", {});
  }

  @override
  Future<bool> destroy() async {
    return await Firefly.channel.invokeMethod("splashDestroy", {});
  }

  @override
  Future<void> win({
    required int price,
    required Map<String, dynamic> map
}) async {
    Map<String, dynamic> filtered = Map.fromEntries(
      map.entries.where((e) =>
      e.value is String || e.value is int || e.value is double || e.value is bool ),
    );
    Map<String, dynamic> args = {
      "price": price,
      "extra": filtered
    };
    await Firefly.channel.invokeMethod("splashWin", args);
  }

  @override
  Future<void> loss({
    required int price,
    required Map<String, dynamic> map
}) async {
    Map<String, dynamic> filtered = Map.fromEntries(
      map.entries.where((e) =>
      e.value is String || e.value is int || e.value is double || e.value is bool ),
    );
    Map<String, dynamic> args = {
      "price": price,
      "extra": filtered
    };
    await Firefly.channel.invokeMethod("splashLoss", args);
  }
}