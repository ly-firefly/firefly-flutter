package com.firefly.yhcadsdk.firefly.init;


import com.firefly.yhcadsdk.firefly.HandleAnyFireflyMethod;
import com.firefly.yhcadsdk.firefly.utils.Const;
import com.firefly.yhcadsdk.firefly.utils.FlutterPluginUtil;
import com.firefly.yhcadsdk.firefly.utils.MsgTools;
import com.firefly.yhcadsdk.sdk.api.YHCAdSdk;
import com.firefly.yhcadsdk.sdk.base.SdkConfig;
import com.firefly.yhcadsdk.sdk.base.api.YHCCustomController;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class YHCInitManger implements HandleAnyFireflyMethod {
    private static YHCInitManger sInstance;

    private YHCInitManger() {

    }

    public static YHCInitManger getInstance() {
        if (sInstance == null) {
            synchronized (YHCInitManger.class) {
                if (sInstance == null) {
                    sInstance = new YHCInitManger();
                }
            }
        }
        return sInstance;
    }

    @Override
    public boolean handleMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) throws Exception {
        switch (methodCall.method) {
            case "initFireFlySDK":
                String appId = methodCall.argument(Const.Init.APP_ID);
                String appName = methodCall.argument(Const.Init.APP_NAME);
                boolean enableDebug = methodCall.argument(Const.Init.ENABLE_DEBUG);
                String oaid = methodCall.argument(Const.Init.OAID);
                boolean isCanUsePhoneState = methodCall.argument(Const.Init.IS_CAN_USE_PHONE_STATE);
                boolean isCanUseAndroidId = methodCall.argument(Const.Init.IS_CAN_USE_ANDROID_ID);
                MsgTools.setLogDebug(enableDebug);
                MsgTools.i(String.format("appId = %s , appName = %s, enableDebug = %s, isCanUsePhoneState = %s, isCanUseAndroidId = %s, oaid = %s", appId, appName, enableDebug, isCanUsePhoneState, isCanUseAndroidId, oaid));
                SdkConfig config = new SdkConfig.Builder()
                        .appId(appId)
                        .debug(enableDebug)
                        .appName(appName)
                        .customController(new YHCCustomController() {
                            @Override
                            public boolean isCanUsePhoneState() {
                                return isCanUsePhoneState;
                            }

                            @Override
                            public String getDevOaid() {
                                return oaid;
                            }

                            @Override
                            public boolean isCanUseAndroidId() {
                                return isCanUseAndroidId;
                            }
                        })
                        .build();
                boolean init = YHCAdSdk.init(FlutterPluginUtil.getApplicationContext(), config);
                result.success(init);
                break;
            case "getAppId":
                String resultAppId = YHCAdSdk.getAppId();
                result.success(resultAppId);
                break;
            case "getSDKVersion":
                String sdkVersion = YHCAdSdk.getSDKVersion();
                result.success(sdkVersion);
                break;
            case "getAppName":
                String resultName = YHCAdSdk.getAppName();
                result.success(resultName);
                break;
        }
        return true;
    }
}
