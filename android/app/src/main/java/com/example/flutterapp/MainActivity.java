package com.example.flutterapp;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String BATTERY_CHANNEL = "samples.flutter.io/battery";
    private static final String CHARGING_CHANNEL = "samples.flutter.io/charging";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new EventChannel(getFlutterView(), CHARGING_CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
            private BroadcastReceiver chargingStateChangeReceiver;

            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                chargingStateChangeReceiver = createChargingStateReceiver(eventSink);
                registerReceiver(chargingStateChangeReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            }

            @Override
            public void onCancel(Object o) {
                unregisterReceiver(chargingStateChangeReceiver);
                chargingStateChangeReceiver=null;

            }
        });
        new MethodChannel(getFlutterView(), BATTERY_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("getBatteryLevel")) {
                    int batteryLevel = getBatteryLevel();
                    if (batteryLevel != -1) {
                        result.success(batteryLevel);
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available", null);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }

    private BroadcastReceiver createChargingStateReceiver(final EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                    events.error("UNAVAILABLE", "Charging status unavailable", null);
                } else {
                    boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL;
                    events.success(isCharging ? "Charging" : "disCharging");
                }
            }
        };
    }

    private int getBatteryLevel() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(Context.BATTERY_SERVICE);
            return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            return intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
    }
}
