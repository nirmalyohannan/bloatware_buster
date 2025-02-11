import 'dart:io';

import 'package:bloatware_buster/constants/package_names.dart';
import 'package:bloatware_buster/logic/adb_handler.dart';
// import 'package:bloatware_buster/logic/console_handler.dart';
import 'package:bloatware_buster/model/app_list_filter.dart';
import 'package:bloatware_buster/model/app_model.dart';
import 'package:bloatware_buster/model/device_model.dart';
import 'package:flutter/material.dart';

class DeviceHandler extends ChangeNotifier {
  //create private constructor and static instance
  DeviceHandler._();
  static final DeviceHandler instance = DeviceHandler._();

  bool isLoadingAppList = false;
  bool isLoadingDevices = false;

  DeviceModel? currentDevice;
  List<DeviceModel> devices = [];
  AppListFilter appListFilter = AppListFilter.all;
  AdbHandler adb = AdbHandler.instance;

  void setCurrentDevice(DeviceModel device) {
    currentDevice = device;
    notifyListeners();
    getCurrentDeviceAppList();
  }

  void getConnectedDevices() async {
    isLoadingDevices = true;
    devices.clear();
    currentDevice = null;
    notifyListeners();

    ProcessResult result = await adb.run(["devices"]);

    if (result.exitCode == 0) {
      String output = result.stdout.toString();
      List<String> lines = output.split("\n");
      lines.removeAt(0); //remove header ("List of devices attached")
      for (int index = 0; index < lines.length; index++) {
        String line = lines[index];
        if (line.isNotEmpty) {
          List<String> parts = line.split("\t");
          if (parts.length > 1) {
            String serialNum = parts[0];
            // String deviceState = parts[1].toString();
            ProcessResult nameResult = await adb
                .run(["-s", serialNum, "shell", "getprop", "ro.product.model"]);
            String deviceName = nameResult.stdout.toString().trim();
            DeviceModel device = DeviceModel(
                serialNumber: serialNum,
                deviceIndex: index,
                deviceName: deviceName);
            devices.add(device);
          }
        }
      }
    }
    isLoadingDevices = false;
    notifyListeners();
  }

  Future<void> getCurrentDeviceAppList() async {
    if (currentDevice == null) {
      return;
    }

    isLoadingAppList = true;
    notifyListeners();
    String filterFlag = filterToFlag(appListFilter);
    List<String> arguments = [
      "shell",
      "pm",
      "list",
      "packages",
      "--user",
      currentDevice!.deviceIndex.toString()
    ];
    if (appListFilter != AppListFilter.all) {
      arguments.add(filterFlag);
    }
    ProcessResult result = await adb.run(arguments, runInShell: true);

    List<AppModel> appList = [];
    if (result.exitCode == 0) {
      String output = result.stdout.toString();
      List<String> lines = output.split("\n");
      lines.removeAt(0); //remove header ("Packages:")
      for (int index = 0; index < lines.length; index++) {
        String line = lines[index];
        if (line.isNotEmpty) {
          List<String> parts = line.split(":");
          if (parts.length > 1) {
            String packageName = parts[1].toString().trim().toLowerCase();
            String? appName = packageNameMap[packageName];
            if (appName != null) {
              appName = appName;
            }

            AppModel app = AppModel(
                packageName: packageName,
                appName: appName,
                deviceIndex: currentDevice!.deviceIndex);
            appList.add(app);
          }
        }
      }
      currentDevice!.apps = appList;
    } else {
      //TODO: Pop up error
    }
    isLoadingAppList = false;
    notifyListeners();
  }

  Future<void> removeApp(
      AppModel app, Future<void> Function(bool isSuccess) beforeCleanUp) async {
    List<String> arguments = [
      "shell",
      "pm",
      "uninstall",
      "--user",
      currentDevice!.deviceIndex.toString(),
      app.packageName
    ];
    ProcessResult result = await adb.run(arguments, runInShell: true);
    if (result.exitCode == 0) {
      await beforeCleanUp(true);
      // getCurrentDeviceAppList();
    } else {
      await beforeCleanUp(false);
    }
    notifyListeners();
  }

  void setAppListFilter(AppListFilter? filter) {
    filter ??= AppListFilter.all;
    appListFilter = filter;
    notifyListeners();
    if (currentDevice != null) getCurrentDeviceAppList();
  }
}


// The recommended ADB command to find a list of apps on your device is:

// adb shell pm list packages
// This command will display a list of all installed packages (apps) on your device, including their package names.

// Here are some additional options you can use with the command:

// -f: This option shows the path to the APK file associated with each package.
// -d: This option filters the results to only show disabled packages.
// -e: This option filters the results to only show enabled packages.
// -s: This option filters the results to only show system apps (pre-installed apps).
// -3: This option filters the results to only show third-party apps (apps you installed yourself).
// -u: This option includes uninstalled packages in the results.
  // -i: see the installer for the packages
  // -l: ignored (used for compatibility with older releases)
  // -U: also show the package UID
  // -u: also include uninstalled packages
  // --uid UID: filter to only show packages with the given UID
  // --user USER_ID: only list packages belonging to the given user
// For example, to see a list of only disabled system apps, you would use the following command:

// adb shell pm list packages -d -s