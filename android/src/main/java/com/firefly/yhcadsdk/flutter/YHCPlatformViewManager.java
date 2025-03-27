package com.firefly.yhcadsdk.flutter;

import com.firefly.yhcadsdk.flutter.splash.YHCSplashViewFactory;
import com.firefly.yhcadsdk.flutter.utils.Const;

import io.flutter.embedding.engine.plugins.FlutterPlugin;

public class YHCPlatformViewManager {

    private static YHCPlatformViewManager sInstance;

    private YHCPlatformViewManager() {
    }

    public synchronized static YHCPlatformViewManager getInstance() {
        if (sInstance == null) {
            synchronized (YHCPlatformViewManager.class) {
                if (sInstance == null) {
                    sInstance = new YHCPlatformViewManager();
                }
            }
        }
        return sInstance;
    }

    public void init(FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
        flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(Const.PlatformViewName.SPLASH_PLATFORM_VIEW, new YHCSplashViewFactory(flutterPluginBinding.getBinaryMessenger()));
    }
}
