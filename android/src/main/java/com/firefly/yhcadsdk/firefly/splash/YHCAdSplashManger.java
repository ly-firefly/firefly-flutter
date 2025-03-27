package com.firefly.yhcadsdk.firefly.splash;

import android.view.View;

import com.firefly.yhcadsdk.firefly.HandleAnyFireflyMethod;
import com.firefly.yhcadsdk.firefly.YHCFlutterEventManager;
import com.firefly.yhcadsdk.firefly.utils.Const;
import com.firefly.yhcadsdk.firefly.utils.FlutterPluginUtil;
import com.firefly.yhcadsdk.firefly.utils.MsgTools;
import com.firefly.yhcadsdk.sdk.api.YHCAdSdk;
import com.firefly.yhcadsdk.sdk.base.api.ads.AdSlot;
import com.firefly.yhcadsdk.sdk.base.api.ads.YHCADManager;
import com.firefly.yhcadsdk.sdk.base.api.ads.YHCAdError;
import com.firefly.yhcadsdk.sdk.base.api.ads.YHCAdNative;
import com.firefly.yhcadsdk.sdk.base.api.ads.YHCSplashAd;
import com.firefly.yhcadsdk.sdk.base.api.core.SdkConst;

import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class YHCAdSplashManger implements HandleAnyFireflyMethod {
    private static YHCAdSplashManger sInstance = null;
    private YHCADManager mYHCADManager;
    private YHCAdNative mAdNative;
    private YHCSplashAd mYHCSplashAd;
    private YHCAdSplashManger() {}

    public static YHCAdSplashManger getInstance() {
        if (sInstance == null) {
            synchronized (YHCAdSplashManger.class) {
                if (sInstance == null) {
                    sInstance = new YHCAdSplashManger();
                }
            }
        }
        return sInstance;
    }


    @Override
    public boolean handleMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) throws Exception {
        switch (methodCall.method) {
            case "loadSplash":
                String adSlotId = methodCall.argument(Const.Splash.AD_SLOT_ID);
                long priceFloor = ((Number) methodCall.argument(Const.Splash.PRICE_FLOOR)).longValue(); //
                YHCAdNative adNative = getAdNative();
                if (adNative != null) {
                    AdSlot adSlot = new AdSlot.Builder()
                            .setAdSlotId(adSlotId)
                            .setPriceFloor(priceFloor)
                            .build();
                    adNative.loadSplashAd(adSlot, new YHCAdNative.SplashAdListener() {
                        @Override
                        public void onSplashLoadSuccess(YHCSplashAd yhcSplashAd) {
                            mYHCSplashAd = yhcSplashAd;
                            result.success(true);
                        }

                        @Override
                        public void onSplashLoadFail(YHCAdError yhcAdError) {
                            result.success(false);
                        }
                    });
                } else {
                    result.success(false);
                }
                break;
            case "splashReady":
                if (mYHCSplashAd != null) {
                    boolean adReady = mYHCSplashAd.isAdReady();
                    MsgTools.i(String.format("adReady = %s", adReady));
                    result.success(adReady);
                } else {
                    result.success(false);
                }
                break;
            case "getSplashAdSlotAd":
                if (mYHCSplashAd != null) {
                    String adSlotAd = mYHCSplashAd.getAdSlotAd();
                    MsgTools.i(String.format("adSlotAd = %s", adSlotAd));
                    result.success(adSlotAd);
                } else {
                    result.success("");
                }
                break;
            case "getSplashEcpm":
                if (mYHCSplashAd != null) {
                    long ecpm = mYHCSplashAd.getEcpm();
                    MsgTools.i(String.format("ecpm = %d", ecpm));
                    result.success(ecpm);
                } else {
                    result.success(0L);
                }
                break;
            case "getSplashMaterialType":
                if (mYHCSplashAd != null) {
                    int materialType = mYHCSplashAd.getMaterialType();
                    MsgTools.i(String.format("materialType = %d", materialType));
                    result.success(materialType);
                } else {
                    result.success(SdkConst.BIDDING_MATERIAL.MATERIAL_OTHER);
                }
                break;
            case "splashDestroy":
                if (mYHCSplashAd != null) {
                    mYHCSplashAd.destroy();
                    mYHCSplashAd = null;
                    result.success(true);
                } else {
                    result.success(false);
                }
                break;

            case "splashWin":
                if (mYHCSplashAd != null) {
                    long price = ((Number) methodCall.argument(Const.Splash.PRICE)).longValue();
                    Map<String, Object> map = methodCall.argument(Const.Splash.EXTRA);
                    mYHCSplashAd.win(price, map);
                    MsgTools.i("splashWin");
                }
                break;
            case "splashLoss":
                if (mYHCSplashAd != null) {
                    long price = ((Number) methodCall.argument(Const.Splash.PRICE)).longValue();
                    Map<String, Object> map = methodCall.argument(Const.Splash.EXTRA);
                    mYHCSplashAd.loss(price, map);
                    MsgTools.i("splashLoss");
                }
                break;
        }
        return true;
    }

    private YHCAdNative getAdNative() {
        if (mYHCADManager == null || mAdNative == null) {
            mYHCADManager = YHCAdSdk.getLoadManager();
            if (mYHCADManager != null) {
                mAdNative = mYHCADManager.createAdNative(FlutterPluginUtil.getActivity());
            }
        }
        return mAdNative;
    }

    public View getYHCSplashView() {
        if (mYHCSplashAd != null) {
            return mYHCSplashAd.getSplashView(new YHCSplashAd.SplashAdInteractionListener() {
                @Override
                public void onAdShow() {
                    MsgTools.i("SplashView");
                    YHCFlutterEventManager.getInstance().sendCallbackMsgToFlutter(Const.CallbackMethodCall.SPLASH_CALL, Const.SplashCallback.ON_AD_SHOW, null, 0);
                }

                @Override
                public void onAdShowError(YHCAdError yhcAdError) {
                    MsgTools.i(String.format("onAdShowError errorMsg = %s , errorCode = %d", yhcAdError.getMsg(), yhcAdError.getCode()));
                    YHCFlutterEventManager.getInstance().sendCallbackMsgToFlutter(Const.CallbackMethodCall.SPLASH_CALL, Const.SplashCallback.ON_AD_SHOW_ERROR, yhcAdError.getMsg(), yhcAdError.getCode());
                }

                @Override
                public void onAdShowEnd() {
                    MsgTools.i("onAdShowEnd");
                    YHCFlutterEventManager.getInstance().sendCallbackMsgToFlutter(Const.CallbackMethodCall.SPLASH_CALL, Const.SplashCallback.ON_AD_SHOW_END, null, 0);

                }

                @Override
                public void onSkippedAd() {
                    MsgTools.i("onSkippedAd");
                    YHCFlutterEventManager.getInstance().sendCallbackMsgToFlutter(Const.CallbackMethodCall.SPLASH_CALL, Const.SplashCallback.ON_SKIPPED_AD, null, 0);

                }

                @Override
                public void onAdClicked() {
                    MsgTools.i("onAdClicked");
                    YHCFlutterEventManager.getInstance().sendCallbackMsgToFlutter(Const.CallbackMethodCall.SPLASH_CALL, Const.SplashCallback.ON_AD_CLICKED, null, 0);

                }
            });
        }
        return null;
    }
}
