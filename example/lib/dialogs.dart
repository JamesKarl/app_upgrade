import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upgrade/upgrade.dart';
import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AppUpgradeDialog extends StatelessWidget {
  final AppInfo appInfo;

  const AppUpgradeDialog({
    Key key,
    @required this.appInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 234,
      height: 279,
      child: Center(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/icons/bg_tc.png",
              width: 234,
              height: 279,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, 38, 22, 0),
              child: Text(
                "V${appInfo?.versionName}",
                style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
              ),
            ),
            Positioned(
              top: 100,
              left: 22,
              right: 22,
              child: SizedBox(
                height: 105,
                child: SingleChildScrollView(
                  child: Text(
                    appInfo?.releaseNote?.length != 0
                        ? "${appInfo?.releaseNote}"
                        : "【更新】功能完善",
                    style: TextStyle(color: Color(0xff252525), fontSize: 14),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 15,
              right: 15,
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    if (appInfo.forceUpgrade == false)
                      RaisedButton(
                        color: const Color(0xffdddddd),
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                        child: Text("以后再说"),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    RaisedButton(
                      color: Colors.amber,
                      textColor: Colors.white,
                      shape: StadiumBorder(),
                      child: Text("立即更新"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppDownloadWidget extends StatefulWidget {
  final String downloadUrl;

  const AppDownloadWidget({
    Key key,
    @required this.downloadUrl,
  }) : super(key: key);

  @override
  _AppDownloadWidgetState createState() => _AppDownloadWidgetState();
}

class _AppDownloadWidgetState extends State<AppDownloadWidget> {
  double progress;
  int totalBytes;
  int downloadBytes;
  String savePath;

  @override
  void initState() {
    progress = 0;
    totalBytes = -1;
    downloadBytes = 0;
    upgradeAppDestPath().then((destPath) async {
      savePath = destPath;
      print("destPath -> $destPath");
      final appPkg = File(destPath);
      if (appPkg.existsSync()) await appPkg.delete();
      Dio().download(
        widget.downloadUrl,
        destPath,
        onReceiveProgress: onReceiveProgress,
      );
    });
    super.initState();
  }

  void onReceiveProgress(int count, int total) {
    if (total != -1) {
      setState(() {
        totalBytes = total;
        downloadBytes = count;
        progress = count * 1.0 / total;
        if (totalBytes == downloadBytes) {
          Navigator.of(context).pop(savePath);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "正在下载新版本",
        style: const TextStyle(fontSize: 18, color: const Color(0xff252525)),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * 0.618,
            lineHeight: 16.0,
            percent: totalBytes != -1 ? progress : 0,
            progressColor: Colors.amber,
            backgroundColor: const Color(0xfff0f0f0),
          ),
          SizedBox(height: 16),
          if (downloadBytes > 0)
            Text(
              "${getPkgSize()}${(progress * 100).toInt()}%",
              style: const TextStyle(color: Color(0xff252525), fontSize: 15),
            ),
        ],
      ),
    );
  }

  String getPkgSize() {
    if (totalBytes == -1) return "";
    return "${(downloadBytes.toDouble() / 1024 / 1024).toStringAsFixed(2)}/${(totalBytes.toDouble() / 1024 / 1024).toStringAsFixed(2)}MB ";
  }
}

Future<String> upgradeAppDestPath() async {
  final dir = await getTemporaryDirectory();
  final packageInfo = await PackageInfo.fromPlatform();
  final destPath = File(
      "${dir.path}${Platform.pathSeparator}${packageInfo.packageName}.${Platform.isAndroid ? "apk" : "ipa"}");
  return destPath.path;
}
