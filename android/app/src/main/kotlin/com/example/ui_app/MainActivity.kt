package com.example.ui_app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import io.flutter.plugin.common.MethodCall


class MainActivity: FlutterActivity() {
    private val channel = "app.id.com/my_channel_name";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor, channel)
            .setMethodCallHandler { call, result ->
                if (call.method == "addnumbers") {
                    val sum: Int = addNumbers(call); // function is written separately,
                    result.success(
                        hashMapOf(
                            "Sum" to sum,
                        )
                    );
                } else {
                    result.notImplemented()
                }

            }
    }

    private fun addNumbers(call: MethodCall): Int {
        val args = call.arguments as Map<String, Any>
        val a = args["n1"] as Int;
        val b = args["n2"] as Int;
        val sum: Int = a + b;
        return sum;
    }

}

    // private fun getBatteryLevel(): Int {
    //     val batteryLevel: Int
    //     if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
    //         val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    //         batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    //     } else {
    //         val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    //         batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    //     }
    //     return batteryLevel
    // }


