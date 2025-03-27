package com.firefly.yhcadsdk.flutter.splash;

import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;

import io.flutter.plugin.platform.PlatformView;

public class YHCAndroidSplashView implements PlatformView {

    private View mYhcSplashView;

    public YHCAndroidSplashView(Context context) {
        mYhcSplashView = YHCAdSplashManger.getInstance().getYHCSplashView();
        if (mYhcSplashView == null) {
            mYhcSplashView = new FrameLayout(context);
        }
    }

    @Override
    public View getView() {
        return mYhcSplashView ;
    }

    @Override
    public void dispose() {

    }
}
