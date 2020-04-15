import 'package:flutter/material.dart';

import 'app_info.dart';

Future<void> mybNoNewVersionHandle(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('提示'),
        content: Text('已是最新版本'),
        actions: <Widget>[
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}

Future<void> mybNewVersionHandle(BuildContext context, AppInfo appInfo) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('提示'),
        content: Text('已是最新版本'),
        actions: <Widget>[
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  );
}

Future<AppInfo> mybNewVersionChecker() {}
