import 'package:flutter/cupertino.dart';
import 'package:upgrade/src/app_info.dart';

abstract class AppVersionChecker {
  ///检查是否有新版本，有新版本返回AppInfo, 没有新版本返回null.
  Future<AppInfo> checkIfHasNewVersion();

  ///没有新版本时会回调这个接口
  Future<void> onNoNewVersion(BuildContext context);

  ///有新版本时会回调这个接口. 确认更新返回true，其它返回false
  Future<bool> onHasNewVersion(BuildContext context, AppInfo appInfo);

  ///下载app的过程，通常会显示一个带进度的下载对话框，最终返回app的下载地址。
  Future<String> onRequireDownloadApp(BuildContext context, AppInfo appInfo);
}
