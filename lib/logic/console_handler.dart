import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class ConsoleHandler extends ChangeNotifier {
  //private constructor
  ConsoleHandler._();
  static final ConsoleHandler instance = ConsoleHandler._();

  List<String> logList = [];

  void clearLog() {
    logList.clear();
    notifyListeners();
  }

  void log(String message) {
    dev.log(message);
    logList.add(message);
    notifyListeners();
  }
}
