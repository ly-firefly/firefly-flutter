package com.firefly.yhcadsdk.firefly.utils;


import java.util.IllegalFormatException;

import androidx.annotation.Nullable;


public class MsgTools {
    public static final String TAG = "YHCFlutterBridge";
    public static boolean showLog = true;

    public static void setLogDebug(boolean debug) {
        showLog = debug;
    }


    /**
     * 将verbose级别日志写入日志文件
     *
     * @param msg  msg
     * @param args the args
     */
    public static void v(String msg, Object... args) {
        if (showLog) {
            android.util.Log.v(TAG, format(msg, args));
        }
    }

    /**
     * 将debug级别日志写入日志文件
     *
     * @param tag Tag
     * @param msg msg
     */
    public static void v(String tag, String msg, Object... args) {
        if (showLog) {
            android.util.Log.v(tag, format(msg, args));
        }
    }


    /**
     * 将debug级别日志写入日志文件
     *
     * @param msg  msg
     * @param args args
     */
    public static void d(String msg, Object... args) {
        if (showLog) {
            android.util.Log.d(TAG, format(msg, args));
        }
    }

    /**
     * 将debug级别日志写入日志文件
     *
     * @param tag tag
     * @param msg msg
     */
    public static void d(String tag, String msg, Object... args) {
        if (showLog) {
            android.util.Log.d(tag, format(msg, args));
        }
    }


    /**
     * 将info级别日志写入日志文件
     *
     * @param msg  msg
     * @param args args
     */
    public static void i(String msg, Object... args) {
        if (showLog) {
            android.util.Log.i(TAG, format(msg, args));
        }
    }

    /**
     * 将info级别日志写入日志文件
     *
     * @param msg  msg
     * @param args args
     */
    public static void i(String tag, String msg, Object... args) {
        if (showLog) {
            android.util.Log.i(tag, format(msg, args));
        }
    }


    /**
     * 将warnning级别日志写入日志文件
     *
     * @param msg  msg
     * @param args args
     */
    public static void w(String msg, Object... args) {
        if (showLog) {
            android.util.Log.i(TAG, format(msg, args));
        }
    }

    /**
     * 将warnning级别日志写入日志文件
     *
     * @param msg  msg
     * @param args args
     */
    public static void w(String tag, String msg, Object... args) {
        if (showLog) {
            android.util.Log.w(tag, format(msg, args));
        }
    }

    /**
     * 打印warn级别的日志，只打印！！！
     *
     * @param throwable 异常信息
     * @param msg       支持 %s 格式的占位符，注意不支持%d, %f等情况。
     * @param args      需要填充格式化占位符的数据
     */
    public static void w(Throwable throwable, String msg, Object... args) {
        if (showLog) {
            android.util.Log.w(TAG, format(msg, args), throwable);
        }
    }

    /**
     * 打印error级别的日志，只打印！！！
     *
     * @param throwable 异常信息
     * @param msg       支持 %s 格式的占位符，注意不支持%d, %f等情况。
     * @param args      需要填充格式化占位符的数据
     */
    public static void e(Throwable throwable, String msg, Object... args) {
        if (showLog) {
            android.util.Log.e(TAG, format(msg, args), throwable);
        }
    }

    /**
     * 将error级别的日志写入日志文件
     *
     * @param msg  msg
     * @param args args
     */
    public static void e(String msg, Object... args) {
        if (showLog) {
            android.util.Log.e(TAG, format(msg, args));
        }
    }

    /**
     * 将error级别的日志写入日志文件
     *
     * @param msg  msg
     * @param args args
     */
    public static void e(String tag, String msg, Object... args) {
        if (showLog) {
            android.util.Log.e(tag, format(msg, args));
        }
    }

    private static String format(@Nullable String str, Object... args) {
        String text = str;
        if (text != null) {
            if (args != null && args.length > 0) {
                try {
                    text = String.format(str, args);
                } catch (IllegalFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        return text;
    }
}
