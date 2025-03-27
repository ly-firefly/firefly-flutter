package com.firefly.yhcadsdk.flutter;

import android.text.TextUtils;

import com.firefly.yhcadsdk.flutter.init.YHCInitManger;
import com.firefly.yhcadsdk.flutter.splash.YHCAdSplashManger;
import com.firefly.yhcadsdk.flutter.utils.Const;
import com.firefly.yhcadsdk.flutter.utils.FlutterPluginUtil;
import com.firefly.yhcadsdk.flutter.utils.MsgTools;
import com.firefly.yhcadsdk.flutter.utils.Utils;

import java.util.HashMap;
import java.util.Map;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class YHCFlutterEventManager {
    private static YHCFlutterEventManager sInstance;
    private MethodChannel mMethodChannel;

    private YHCFlutterEventManager() {

    }

    public static YHCFlutterEventManager getInstance() {
        if (sInstance == null) {
            synchronized (YHCFlutterEventManager.class) {
                if (sInstance == null) {
                    sInstance = new YHCFlutterEventManager();
                }
            }
        }
        return sInstance;
    }

    public void init(BinaryMessenger binaryMessenger) {
        if (mMethodChannel == null) {
            mMethodChannel = new MethodChannel(binaryMessenger, "firefly");
            mMethodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                @Override
                public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
                    try {
                        if (Utils.checkMethodInArray(Const.initMethodNames, methodCall.method)) {
                            YHCInitManger.getInstance().handleMethodCall(methodCall, result);
                        } else if (Utils.checkMethodInArray(Const.splashMethodNames, methodCall.method)) {
                            YHCAdSplashManger.getInstance().handleMethodCall(methodCall, result);
                        }
                    } catch (Throwable e) {
                        MsgTools.e("method call error: " + methodCall + ", " + e.getMessage());
                        e.printStackTrace();
                    }
                }
            });
        }

    }

    public void sendCallbackMsgToFlutter(String callName, String callbackName, String errorMsg, int errorCode) {
        final Map<String, Object> paramsMap = new HashMap<>();
        paramsMap.put(Const.CallbackKey.CALL_BACK_NAME, callbackName);
        if (!TextUtils.isEmpty(errorMsg)) {
            paramsMap.put(Const.CallbackKey.ERROR_MSG, errorMsg);
        } else {
            paramsMap.put(Const.CallbackKey.ERROR_MSG, "");
        }
        paramsMap.put(Const.CallbackKey.ERROR_CODE, errorCode);

        FlutterPluginUtil.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    if (mMethodChannel != null) {
                        mMethodChannel.invokeMethod(callName, paramsMap);
                    }
                } catch (Throwable e) {
                    MsgTools.e("sendCallbackMsgToFlutter invokeMethod error: " + callName + ", " + e.getMessage());
                    e.printStackTrace();
                }
            }
        });
    }


    public void release() {
        if (mMethodChannel != null) {
            mMethodChannel.setMethodCallHandler(null);
            mMethodChannel = null;
        }
    }
}
