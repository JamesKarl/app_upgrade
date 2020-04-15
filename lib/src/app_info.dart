class AppInfo {
  final bool hasNewVersion;
  final String versionName;
  final String versionCode;
  final String releaseNote;
  final String downloadURL;
  final bool forceUpgrade;
  final bool upgradeByBrowser;

  AppInfo({
    this.hasNewVersion,
    this.versionName,
    this.versionCode,
    this.releaseNote,
    this.downloadURL,
    this.forceUpgrade,
    this.upgradeByBrowser = false,
  });
}
