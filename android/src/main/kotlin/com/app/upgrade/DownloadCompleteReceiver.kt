package com.app.upgrade

import android.app.DownloadManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.blankj.utilcode.util.AppUtils
import com.blankj.utilcode.util.UriUtils

class DownloadCompleteReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent) {
        if (context != null && intent.action == DownloadManager.ACTION_DOWNLOAD_COMPLETE) {
            val completeDownloadId = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, -1L)
            if (completeDownloadId != -1L) {
                val downloadManager = context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
                downloadManager.getUriForDownloadedFile(completeDownloadId)?.apply {
                    val apkFile = UriUtils.uri2File(this)
                    if (apkFile != null) {
                        Log.d("upgrade", "apk path ${apkFile.absolutePath}")
                        AppUtils.installApp(apkFile)
                    }
                }
            }
        }
    }
}
