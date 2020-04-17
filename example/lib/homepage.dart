import 'package:flutter/material.dart';
import 'package:upgrade/upgrade.dart';
import 'demo_cheker.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity),
          RaisedButton(
            shape: StadiumBorder(),
            color: Colors.blue,
            child: Text(
              "用系统浏览器强制升级",
              style: const TextStyle(color: Colors.white),
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
            child: Text(
              "用系统浏览器非强制升级",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              AppUpgrade.checkUpdate(context,
                  checker: DemoChecker(
                    forceUpgrade: false,
                    installByBrowser: true,
                  ));
            },
          ),
          RaisedButton(
            shape: StadiumBorder(),
            color: Colors.purple,
            child: Text(
              "应用内强制升级",
              style: const TextStyle(color: Colors.white),
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
            child: Text(
              "应用内非强制升级",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              AppUpgrade.checkUpdate(context,
                  checker: DemoChecker(
                    forceUpgrade: false,
                    installByBrowser: false,
                  ));
            },
          )
        ],
      ),
    );
  }
}
