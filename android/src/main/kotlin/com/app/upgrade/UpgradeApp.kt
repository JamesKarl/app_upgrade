package com.app.upgrade

import android.app.Activity
import android.app.DownloadManager
import android.content.Context
import android.net.Uri
import android.os.Environment
import android.widget.Toast
import com.blankj.utilcode.constant.PermissionConstants
import com.blankj.utilcode.util.ActivityUtils
import com.blankj.utilcode.util.AppUtils
import com.blankj.utilcode.util.PermissionUtils
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

object UpgradeApp {
    
    fun installApp(call: MethodCall, result: MethodChannel.Result) {
        result.success(null)
        AppUtils.installApp(call.argument<String>("appLocalPath"))
    }

    fun downloadInstallApp(call: MethodCall, result: MethodChannel.Result) {
        result.success(null)
        val downloadUrl = call.argument<String>("downloadUrl")
        if (downloadUrl != null) {
            downloadApkInBackground(downloadUrl)
        }
    }

    private fun downloadApkInBackground(downloadUrl: String) {
        ActivityUtils.getTopActivity()?.also { context ->
            if (PermissionUtils.isGranted(PermissionConstants.STORAGE)) {
                startDownloadApk(context, downloadUrl)
            } else {
                PermissionUtils.permission(PermissionConstants.STORAGE)
                        .callback(object : PermissionUtils.SimpleCallback {
                            override fun onGranted() {
                                startDownloadApk(context, downloadUrl)
                            }

                            override fun onDenied() {
                                Toast.makeText(context, "没有访问存储卡权限，无法升级", Toast.LENGTH_SHORT).show()
                            }

                        }).request()
            }
        }
    }

    private fun startDownloadApk(context: Activity, downloadUrl: String) {
        val downloadManager = context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        DownloadManager.Request(Uri.parse(downloadUrl))
                .apply {
                    setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, "${AppUtils.getAppPackageName()}.apk")
                    setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)
                    setVisibleInDownloadsUi(true)
                    setTitle("正在下载${AppUtils.getAppName()}最新安装包")
                    downloadManager.enqueue(this)
                }
    }
}