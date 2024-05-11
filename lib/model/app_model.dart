class AppModel {
  int deviceIndex;
  String? appName;
  String packageName;
  String? version;
  String? logoPath;
  String? recommendation;
  bool isRemoved = false; //for animation during deletion
  AppModel({
    required this.deviceIndex,
    this.appName,
    required this.packageName,
    this.version,
    this.logoPath,
    this.recommendation,
  });
}
