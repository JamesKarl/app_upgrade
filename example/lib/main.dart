import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upgrade/upgrade.dart';
import 'package:upgrade_example/demo_cheker.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with CheckAppUpgradeMixin<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }

  @override
  AppVersionChecker getAppVersionChecker() {
    return DemoChecker(forceUpgrade: false, installByBrowser: false);
  }
}
