import 'dart:io';

import 'package:bloatware_buster/logic/console_handler.dart';
import 'package:flutter/foundation.dart';

class AdbHandler extends ChangeNotifier {
  AdbHandler._();

  static final AdbHandler instance = AdbHandler._();
  String? adbPath;
  String? adbExePath;

  Future<bool> findAdbPath() async {
    ConsoleHandler.instance.log("Getting adb path...");
    String programPath = Directory.current.path;
    if (kReleaseMode) {
      adbPath = "$programPath\\data\\flutter_assets\\adb_driver";
    } else {
      adbPath = "$programPath\\adb_driver";
    }
    adbExePath = "$adbPath\\adb.exe";
    var uri = Uri.file(adbPath!);
    var adbDirectory = Directory.fromUri(uri);
    if (adbDirectory.existsSync()) {
      var result = await Process.run(adbExePath!, ['--version']);
      if (result.exitCode == 0) {
        ConsoleHandler.instance.log("adb driver loaded");
        return true;
      } else {
        ConsoleHandler.instance.log("adb command not working");
      }
    } else {
      ConsoleHandler.instance.log("adb driver not found");
    }
    adbPath = null;

    return false;
  }

  Future<ProcessResult> run(List<String> arguments,
      {bool runInShell = false}) async {
    if (adbExePath == null) {
      await findAdbPath();
    }
    ConsoleHandler.instance.log("adb ${arguments.join(" ")}");
    ProcessResult result =
        await Process.run(adbExePath!, arguments, workingDirectory: adbPath);
    ConsoleHandler.instance.log("Exit Code: ${result.exitCode}");
    ConsoleHandler.instance.log("Output: ${result.stdout.toString()}");
    if (result.exitCode != 0) {
      ConsoleHandler.instance.log("Error: ${result.stderr.toString()}");
    }
    return result;
  }
}
