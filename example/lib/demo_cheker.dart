import 'package:flutter/material.dart';
import 'package:upgrade/upgrade.dart';
import 'dart:math';

import 'dialogs.dart';

class DemoChecker extends AppVersionChecker {
  final bool forceUpgrade;
  final bool installByBrowser;

  static const appDownloadUrl =
      "http://download.jappstore.com/apps/5cc56ba0959d6905c7d6a127/install?download_token=5fab42f2d0d65c72b070a21c88a1726c&source=update";

  DemoChecker({
    @required this.forceUpgrade,
    @required this.installByBrowser,
  });

  @override
  Future<AppInfo> checkIfHasNewVersion() async {
    final hasNewVersion = Random().nextBool();
    if (hasNewVersion) {
      return AppInfo(
          hasNewVersion: true,
          versionCode: "123",
          versionName: "1.2.3",
          releaseNote: """
          1. 找到了新冠肺炎的源头。
          2. 研制出了疫苗。
          3. 找到了避免传染的有效方法。
        """,
          downloadURL: appDownloadUrl,
          forceUpgrade: forceUpgrade,
          upgradeByBrowser: installByBrowser);
    } else {
      return null;
    }
  }

  @override
  Future<bool> onHasNewVersion(BuildContext context, AppInfo appInfo) {
    return showDialog(
        barrierDismissible: appInfo.forceUpgrade == false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return appInfo.forceUpgrade == false;
            },
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: AppUpgradeDialog(appInfo: appInfo),
            ),
          );
        });
  }

  @override
  Future<void> onNoNewVersion(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("已经最新版本"),
            actions: <Widget>[
              RaisedButton(
                child: Text("知道啦！"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Future<String> onRequireDownloadApp(BuildContext context, AppInfo appInfo) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AppDownloadWidget(downloadUrl: appInfo.downloadURL);
      },
    );
  }
}
