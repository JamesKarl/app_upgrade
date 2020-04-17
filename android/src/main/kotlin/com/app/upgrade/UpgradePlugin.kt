package com.app.upgrade

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** UpgradePlugin */
class UpgradePlugin : FlutterPlugin, MethodCallHandler {
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelName)
        channel.setMethodCallHandler(UpgradePlugin())
    }

    companion object {
        const val channelName = "app_upgrade"
        const val installAppMethod = "installApp"
        const val downloadInstallAppMethod = "downloadInstallApp"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), channelName)
            channel.setMethodCallHandler(UpgradePlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d(channelName, "onMethodCall ${call.method}(${call.arguments})")
        when (call.method) {
            installAppMethod -> {
                UpgradeApp.installApp(call, result)
            }
            downloadInstallAppMethod -> {
                UpgradeApp.downloadInstallApp(call, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
