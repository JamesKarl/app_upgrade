import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrade/src/app_version_checker.dart';
import 'package:upgrade/src/myb_checker.dart';

abstract class AppUpgrade {
  static const MethodChannel _channel = const MethodChannel('upgrade');
  static bool _upgradeDialogDisplayed = false;

  bool get installingAppInBackground => _installingAppInBackground;
  static bool _installingAppInBackground = false;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void checkUpdate(
    BuildContext context, {
    AppVersionChecker checker,
    bool showMessageWhenNoNewVersion = true,
  }) async {
    assert(context != null);
    assert(checker != null);
    assert(showMessageWhenNoNewVersion != null);

    final appInfo = await checker.checkIfHasNewVersion();
    if (appInfo?.hasNewVersion ?? false) {
      ///有新版本
      if (_upgradeDialogDisplayed == false) {
        _upgradeDialogDisplayed = true;
        checker.onHasNewVersion(context, appInfo).then((confirmUpgrade) {
          _installingAppInBackground = confirmUpgrade == true;
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
}
