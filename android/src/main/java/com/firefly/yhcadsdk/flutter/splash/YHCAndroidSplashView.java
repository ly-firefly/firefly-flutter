package com.firefly.yhcadsdk.flutter.splash;

import android.view.View;

import io.flutter.plugin.platform.PlatformView;

public class YHCAndroidSplashView implements PlatformView {

    private View mYhcSplashView;

    public YHCAndroidSplashView() {
        mYhcSplashView = YHCAdSplashManger.getInstance().getYHCSplashView();
    }

    @Override
    public View getView() {
        return mYhcSplashView;
    }

    @Override
    public void dispose() {

    }
}
