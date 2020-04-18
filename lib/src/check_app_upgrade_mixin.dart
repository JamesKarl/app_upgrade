import 'package:flutter/material.dart';
import 'package:upgrade/src/app_version_checker.dart';

import 'app_upgrade_main.dart';

class _AppStateObserver extends WidgetsBindingObserver {
  final VoidCallback onAppResumed;

  _AppStateObserver(this.onAppResumed);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState = $state");
    if (state == AppLifecycleState.resumed) {
      onAppResumed();
    }
  }
}

mixin CheckAppUpgradeMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_AppStateObserver(onAppResumed));
    onAppResumed();
  }

  void onAppResumed() {
    if (AppUpgrade.installingAppInBackground) return;
    if (context != null && mounted) {
      AppUpgrade.checkUpdate(
        context,
        checker: getAppVersionChecker(),
        showMessageWhenNoNewVersion: false,
      );
    } else {
      Future.delayed(Duration(seconds: 2), () {
        if (context != null && mounted) {
          AppUpgrade.checkUpdate(
            context,
            checker: getAppVersionChecker(),
            showMessageWhenNoNewVersion: false,
          );
        }
      });
    }
  }

  AppVersionChecker getAppVersionChecker();
}
