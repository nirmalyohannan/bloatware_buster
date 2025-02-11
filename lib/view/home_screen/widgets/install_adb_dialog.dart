import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:flutter/material.dart';

import 'package:bloatware_buster/logic/adb_handler.dart';

class InstallAdbDialog extends StatefulWidget {
  const InstallAdbDialog({super.key});

  @override
  State<InstallAdbDialog> createState() => _InstallAdbDialogState();
}

class _InstallAdbDialogState extends State<InstallAdbDialog> {
  @override
  void initState() {
    AdbHandler.instance.resetInstallationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: AdbHandler.instance,
        builder: (context, child) {
          var installationData = AdbHandler.instance.installationData;
          bool isInstalling = installationData.isAdbInstalling;
          return AlertDialog(
            title: isInstalling
                ? const Text("Installing ADB...")
                : const Text("Install ADB?"),
            content: isInstalling
                ? Text(installationData.installationMessage ?? "Installing...")
                : const Text(
                    "ADB is not installed. It is required to use this tool."),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              if (isInstalling) const CircularProgressIndicator(),
              if (!isInstalling)
                TextButton(
                    onPressed: () {
                      AdbHandler.instance.installAdb(
                        onSuccess: () {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                          DeviceHandler.instance.getConnectedDevices();
                        },
                      );
                    },
                    child: const Text("Install")),
            ],
          );
        });
  }
}
