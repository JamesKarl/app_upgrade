import 'package:flutter/material.dart';
import 'package:upgrade/upgrade.dart';
import 'demo_cheker.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('应用升级demo'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 16),
          buildButtons(context),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(width: double.infinity),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.open_in_browser,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "强制升级",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                AppUpgrade.checkUpdate(context,
                    checker: DemoChecker(
                      forceUpgrade: true,
                      installByBrowser: true,
                    ));
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.blueAccent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.open_in_browser,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "非强制升级",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                AppUpgrade.checkUpdate(context,
                    checker: DemoChecker(
                      forceUpgrade: false,
                      installByBrowser: true,
                    ));
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.purple,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.apps,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "强制升级",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                AppUpgrade.checkUpdate(context,
                    checker: DemoChecker(
                      forceUpgrade: true,
                      installByBrowser: false,
                    ));
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.purpleAccent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.apps,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "非强制升级",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                AppUpgrade.checkUpdate(context,
                    checker: DemoChecker(
                      forceUpgrade: false,
                      installByBrowser: false,
                    ));
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        RaisedButton(
          shape: StadiumBorder(),
          color: Colors.black87,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.file_download,
                color: Colors.white,
              ),
              SizedBox(width: 8.0),
              Text(
                "直接安装apk",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: () {
            AppUpgrade.installAppDirectly(
                "/data/user/0/com.app.upgrade_example/cache/com.app.upgrade_example.apk");
          },
        )
      ],
    );
  }
}
