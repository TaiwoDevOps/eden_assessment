package com.example.eden_app

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger
        setupChannels(binaryMessenger)

    }

    private fun setupChannels(messenger: BinaryMessenger) {

        val methodChannel = MethodChannel(messenger, "co.ourpass.pos/channel")
        methodChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            val method = call.method
            println("PRINT ==> ASDFSDFDSFDSF ==>" + method)
            when (method) {
                "start_television" -> {
                    val intent = Intent(this, TelevisionActivity::class.java)
                    startActivity(intent)

                }
            }

        }
    }
}
