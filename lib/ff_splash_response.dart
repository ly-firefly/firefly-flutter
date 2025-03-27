enum AdStatus {
  onAdShow,
  onAdShowError,
  onAdShowEnd,
  onSkippedAd,
  onAdClicked,
  onAdUnknown
}

class YHCSplashResponse {
  final AdStatus splashStatus;
  final String errorMsg;
  final int errorCode;
  YHCSplashResponse(this.splashStatus, this.errorCode, this.errorMsg);

  factory YHCSplashResponse.withMap(Map map) {
    var errorMsg = map["errorMsg"];
    var errorCode = map["errorCode"];
    var callbackName = map["callbackName"];
    if (callbackName == "onAdShow") {
      callbackName = AdStatus.onAdShow;
    } else if (callbackName == "onAdShowError") {
      callbackName = AdStatus.onAdShowError;
    } else if (callbackName == "onAdShowEnd") {
      callbackName = AdStatus.onAdShowEnd;
    } else if (callbackName == "onSkippedAd") {
      callbackName = AdStatus.onSkippedAd;
    } else if (callbackName == "onAdClicked") {
      callbackName = AdStatus.onAdClicked;
    } else {
      callbackName = AdStatus.onAdUnknown;
    }
    return YHCSplashResponse(callbackName, errorCode, errorMsg);
  }
}
