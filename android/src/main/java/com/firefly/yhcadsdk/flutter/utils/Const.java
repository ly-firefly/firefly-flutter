package com.firefly.yhcadsdk.flutter.utils;

public class Const {

    public static class Init {
        public static final String APP_ID = "appId";
        public static final String APP_NAME = "appName";
        public static final String ENABLE_DEBUG = "enableDebug";
        public static final String IS_CAN_USE_PHONE_STATE = "isCanUsePhoneState";
        public static final String OAID = "oaid";
        public static final String IS_CAN_USE_ANDROID_ID = "isCanUseAndroidId";
    }

    public static class Splash {
        public static final String AD_SLOT_ID = "adSlotId";
        public static final String PRICE_FLOOR = "priceFloor";
        public static final String PRICE = "price";
        public static final String EXTRA = "extra";
    }

    public static class PlatformViewName {
        public static final String SPLASH_PLATFORM_VIEW = "ff_splash_platform_view";
    }

    public static class CallbackKey {
        public static final String CALL_BACK_NAME = "callbackName";
        public static final String ERROR_MSG = "errorMsg";
        public static final String ERROR_CODE = "errorCode";

    }

    public static class CallbackMethodCall {
        public static final String SPLASH_CALL = "SplashCall";
    }

    public static class SplashCallback {
        public static final String ON_AD_SHOW = "onAdShow";
        public static final String ON_AD_SHOW_ERROR = "onAdShowError";
        public static final String ON_AD_SHOW_END = "onAdShowEnd";
        public static final String ON_SKIPPED_AD = "onSkippedAd";
        public static final String ON_AD_CLICKED = "onAdClicked";
    }

    public static String[] initMethodNames = {"initFireFlySDK", "getAppId", "getSDKVersion", "getAppName"};
    public static String[] splashMethodNames = {"loadSplash", "splashReady", "getSplashAdSlotAd", "getSplashEcpm", "getSplashMaterialType", "splashDestroy", "splashWin", "splashLoss"};
}
