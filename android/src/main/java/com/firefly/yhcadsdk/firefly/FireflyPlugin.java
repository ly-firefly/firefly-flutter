package com.firefly.yhcadsdk.firefly;

import com.firefly.yhcadsdk.firefly.utils.FlutterPluginUtil;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/**
 * FireflyPlugin
 */
public class FireflyPlugin implements FlutterPlugin, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        YHCFlutterEventManager.getInstance().init(flutterPluginBinding.getBinaryMessenger());
        YHCPlatformViewManager.getInstance().init(flutterPluginBinding);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        YHCFlutterEventManager.getInstance().release();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        FlutterPluginUtil.setActivity(binding.getActivity());
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }
}
