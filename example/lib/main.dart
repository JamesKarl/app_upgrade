import 'package:flutter/material.dart';
import 'dart:async';

import 'package:upgrade/upgrade.dart';

import 'demo_cheker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}
