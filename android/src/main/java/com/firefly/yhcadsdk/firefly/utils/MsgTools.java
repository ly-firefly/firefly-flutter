package com.anythink.flutter.utils;

import android.util.Log;


public class MsgTools {
    public static final String TAG = "ATFlutterBridge";
    public static boolean isDebug = true;

    public static void printMsg(String msg) {
        if (isDebug) {
            logLongMsg(TAG, msg, false, null);
        }
    }

    public static void setLogDebug(boolean debug) {
        isDebug = debug;
    }

    public static void logLongMsg(String TAG, String message, boolean logError, Throwable throwable) {
        //因为String的length是字符数量不是字节数量所以为了防止中文字符过多，
        //  把4*1024的MAX字节打印长度改为2001字符数
        int max_str_length = 2001 - TAG.length();
        //大于4000时
        while (message.length() > max_str_length) {
            if (logError) {
                Log.e(TAG, message.substring(0, max_str_length), throwable);
            } else {
                Log.i(TAG, message.substring(0, max_str_length));
            }

            message = message.substring(max_str_length);
        }
        //剩余部分
        if (logError) {
            Log.e(TAG, message, throwable);
        } else {
            Log.i(TAG, message);
        }
    }
}
