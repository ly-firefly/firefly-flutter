package com.firefly.yhcadsdk.firefly.splash;

import android.content.Context;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class YHCSplashViewFactory extends PlatformViewFactory {

    BinaryMessenger messenger;

    public YHCSplashViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new YHCAndroidSplashView();
    }
}
