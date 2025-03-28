abstract class YHCIBaseAd {
  // 广告是否准备完成
  Future<bool> isAdReady() ;
  // 获取广告位
  Future<String> getAdSlotAd();
  // 获取requestId
  Future<String> getRequestId();
  // 销毁物料
  Future<bool> destroy();


}