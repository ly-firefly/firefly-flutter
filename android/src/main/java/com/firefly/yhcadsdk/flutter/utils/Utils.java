package com.firefly.yhcadsdk.flutter.utils;

public class Utils {
    public static boolean checkMethodInArray(String[] methodArray, String methodName) {
        for (String method : methodArray) {
            if (method.equals(methodName))
                return true;
        }
        return false;
    }
}
