import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrade/src/app_info.dart';
import 'package:upgrade/src/app_version_checker.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AppUpgrade {
  static const _installAppMethod = "installApp";
  static const _downloadInstallAppMethod = "downloadInstallApp";
  static const _channelName = "app_upgrade";

  static const MethodChannel _channel = const MethodChannel(_channelName);
  static bool _upgradeDialogDisplayed = false;

  static bool get installingAppInBackground => _installingAppInBackground;
  static bool _installingAppInBackground = false;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void checkUpdate(
    BuildContext context, {
    @required AppVersionChecker checker,
    bool showMessageWhenNoNewVersion = true,
  }) async {
    assert(context != null);
    assert(checker != null);
    assert(showMessageWhenNoNewVersion != null);

    final appInfo = await checker.checkIfHasNewVersion();
    print("appInfo: $appInfo");
    if (appInfo?.hasNewVersion ?? false) {
      ///有新版本
      if (_upgradeDialogDisplayed == false) {
        _upgradeDialogDisplayed = true;
        checker.onHasNewVersion(context, appInfo).then((confirmUpgrade) {
          _installingAppInBackground = confirmUpgrade == true;
          if (confirmUpgrade == true) {
            _installApp(context, appInfo, checker);
          }
        }).whenComplete(() {
          _upgradeDialogDisplayed = false;
        });
      }
    } else {
      ///没有新版本
      if (showMessageWhenNoNewVersion && !_upgradeDialogDisplayed) {
        ///提示:"已是最新版本"
        _upgradeDialogDisplayed = true;
        checker.onNoNewVersion(context).whenComplete(() {
          _upgradeDialogDisplayed = false;
        });
      }
    }
  }

  static void _installApp(
    BuildContext context,
    AppInfo appInfo,
    AppVersionChecker checker,
  ) {
    if (Platform.isIOS) {
      _upgradeAppByBrowser(appInfo.downloadURL);
    } else {
      if (appInfo.upgradeByBrowser == true) {
        _upgradeAppByBrowser(appInfo.downloadURL);
      } else {
        if (appInfo.forceUpgrade) {
          checker
              .onRequireDownloadApp(context, appInfo)
              .then(_installAppDirectly);
        } else {
          _downloadInstallApp(appInfo.downloadURL);
        }
      }
    }
  }

  ///直接安装下载好的apk
  static Future<void> _installAppDirectly(String appLocalPath) async {
    print("_installAppDirectly appLocalPath = $appLocalPath");
    if (appLocalPath == null) return null;
    try {
      return _channel.invokeMethod(_installAppMethod, {
        "appLocalPath": appLocalPath,
      });
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  ///后台下载apk，下载完成后启动安装流程
  static Future<void> _downloadInstallApp(String downloadUrl) async {
    print("_downloadInstallApp downloadUrl = $downloadUrl");
    try {
      return _channel.invokeMethod(_downloadInstallAppMethod, {
        "downloadUrl": downloadUrl,
      });
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  static void _upgradeAppByBrowser(String downloadUrl) {
    try {
      _launchUrl(downloadUrl);
    } catch (e) {
      print(e);
    }
  }

  static Future _launchUrl(String url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    }
  }
}
