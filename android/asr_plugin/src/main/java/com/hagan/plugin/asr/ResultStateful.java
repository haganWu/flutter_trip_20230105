package com.hagan.plugin.asr;

import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.plugin.common.MethodChannel;

public class ResultStateful implements MethodChannel.Result {

    private static final String TAG = "ResultStateful";
    private MethodChannel.Result result;
    private boolean called;

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }

    @Override
    public void success(@Nullable Object o) {
        if(called) {
            printError();
            return;
        }
        called = true;
        result.success(o);
    }

    @Override
    public void error(@NonNull String errorCode, @Nullable String errorMessage, @Nullable Object o) {
        if(called) {
            printError();
            return;
        }
        called = true;
        result.error(errorCode,errorMessage,o);
    }

    @Override
    public void notImplemented() {
        if(called) {
            printError();
            return;
        }
        called = true;
        result.notImplemented();
    }

    private void printError() {
        Log.e(TAG, "error:result called");
    }
}
