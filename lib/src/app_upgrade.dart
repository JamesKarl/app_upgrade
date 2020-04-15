import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shop_mobile/AppConfigs.dart';

import 'utils/platform_apis.dart';

bool _installingAppInBackground = false;

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

mixin AppUpgradeMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_AppStateObserver(onAppResumed));
    onAppResumed();
  }

  void onAppResumed() {
    if (_installingAppInBackground) return;
    if (context != null && mounted) {
      PlatformApis.checkUpdate(context, showMessage: false);
      // AppPermissions.update(); 如果权限变了,token会失效,会重新登录,所以此处刷新权限没有必要
    } else {
      Future.delayed(Duration(seconds: 2), () {
        if (context != null && mounted) {
          PlatformApis.checkUpdate(context, showMessage: false);
        }
      });
    }
  }
}
