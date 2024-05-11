import 'package:bloatware_buster/model/app_model.dart';

class DeviceModel {
  String deviceName;
  int deviceIndex;
  List<AppModel> apps = [];
  DeviceModel({
    required this.deviceName,
    required this.deviceIndex,
  });
}
