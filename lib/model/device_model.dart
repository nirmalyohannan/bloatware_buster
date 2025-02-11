import 'package:bloatware_buster/model/app_model.dart';

class DeviceModel {
  String serialNumber;
  String? deviceName;
  int deviceIndex;
  List<AppModel> apps = [];
  DeviceModel({
    required this.serialNumber,
    required this.deviceIndex,
    this.deviceName,
  });
}
