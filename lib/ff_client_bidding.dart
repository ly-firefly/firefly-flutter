abstract class YHCClientBidding {
  // 获取广告物料类型
  Future<int> getMaterialType();
  // 获取ecpm
  Future<int> getEcpm();

  // 竞胜回传
  Future<void> win({
    required int price,
    required Map<String, dynamic> map
  });
  // 竞败回传
  Future<void> loss({
    required int price,
    required Map<String, dynamic> map
  });
}