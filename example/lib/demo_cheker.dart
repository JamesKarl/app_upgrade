import 'package:flutter/material.dart';
import 'package:upgrade/upgrade.dart';

class DemoChecker extends AppVersionChecker {
  final bool forceUpgrade;
  final bool installByBrowser;

  DemoChecker({
    @required this.forceUpgrade,
    @required this.installByBrowser,
  });

  @override
  Future<AppInfo> checkIfHasNewVersion() {
    // TODO: implement checkIfHasNewVersion
    return null;
  }

  @override
  Future<bool> onHasNewVersion(BuildContext context, AppInfo appInfo) {
    // TODO: implement onHasNewVersion
    return null;
  }

  @override
  Future<void> onNoNewVersion(BuildContext context) {
    // TODO: implement onNoNewVersion
    return null;
  }

  @override
  Future<String> onRequireDownloadApp(BuildContext context, AppInfo appInfo) {
    // TODO: implement onRequireDownloadApp
    return null;
  }
}
