import 'dart:io';

import 'package:bloatware_buster/logic/console_handler.dart';
import 'package:bloatware_buster/model/adb_installation_model.dart';
import 'package:bloatware_buster/utils/listen_log_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdbHandler extends ChangeNotifier {
  AdbHandler._();

  static final AdbHandler instance = AdbHandler._();
  String? adbPath;
  String adbExecutable = "adb"; //Default adb path

  AdbInstallationModel installationData = AdbInstallationModel();
  void resetInstallationData() {
    installationData = AdbInstallationModel();
    notifyListeners();
  }

  Future<ProcessResult> run(List<String> arguments,
      {bool runInShell = false}) async {
    ConsoleHandler.instance.log("adb ${arguments.join(" ")}");
    ProcessResult result =
        await Process.run(adbExecutable, arguments, workingDirectory: adbPath);
    ConsoleHandler.instance.log("Exit Code: ${result.exitCode}");
    ConsoleHandler.instance.log("Output: ${result.stdout.toString()}");
    if (result.exitCode != 0) {
      ConsoleHandler.instance.log("Error: ${result.stderr.toString()}");
    }
    return result;
  }

  Future<bool> isAdbInstalled() async {
    try {
      ConsoleHandler.instance.log("Checking if ADB is installed...");
      ConsoleHandler.instance.log("adb --version");
      ProcessResult result = await Process.run("adb", ["--version"]);
      ConsoleHandler.instance.log(result.stdout.toString());
      return result.exitCode == 0;
    } catch (e) {
      ConsoleHandler.instance.log(e.toString());
      return false;
    }
  }

  Future<void> installAdb(
      {ValueChanged<String>? onFail, VoidCallback? onSuccess}) async {
    try {
      installationData.isAdbInstalling = true;
      notifyListeners();
      if (Platform.isWindows) {
        //TODO: INSTALL ADB FOR WINDOWS
        throw Exception("Not implemented");
      } else if (Platform.isMacOS) {
        installationData.installationMessage = "Installing ADB for macOS...";
        notifyListeners();
        await _installMacAdb(onFail: onFail, onSuccess: onSuccess);
        onSuccess?.call();
      } else {
        throw Exception("Unsupported platform");
      }
    } catch (e) {
      installationData.installationMessage = e.toString();
      ConsoleHandler.instance.log(e.toString());
      onFail?.call(e.toString());
    }
  }

  Future<void> _installMacAdb(
      {ValueChanged<String>? onFail, VoidCallback? onSuccess}) async {
    listenLogFile(
        onFail: onFail,
        onSuccess: onSuccess,
        logFile: File("assets/scripts/install_log.log"));
    //Install homebrew and ADB
    ProcessResult result = await Process.run("open",
        ["-a", "Terminal", "assets/scripts/install_homebrew.sh", "&&", "exit"],
        runInShell: false);
    ConsoleHandler.instance.log(result.stdout.toString());
    if (result.exitCode != 0) {
      throw Exception("Failed to install Adb");
    }
  }
}
