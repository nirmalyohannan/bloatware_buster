import 'dart:io';

import 'package:flutter/services.dart';

void listenLogFile(
    {ValueChanged<String>? onFail,
    VoidCallback? onSuccess,
    VoidCallback? atEnd,
    required File logFile}) async {
  bool isFileExists = logFile.existsSync();
  while (!isFileExists) {
    await Future.delayed(const Duration(seconds: 1));
    isFileExists = logFile.existsSync();
  }
  String message = "";
  // Wait for log file creation
  while (message.isEmpty) {
    await Future.delayed(const Duration(seconds: 1));
    message = logFile.readAsStringSync().trim();
  }

  if (message == "success") {
    if (onSuccess != null) {
      onSuccess();
    }
  } else {
    onFail?.call("Failed to install Adb");
  }

  if (atEnd != null) {
    atEnd();
  }
}
