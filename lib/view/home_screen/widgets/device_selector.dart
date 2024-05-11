import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:flutter/material.dart';

class DeviceSelector extends StatelessWidget {
  const DeviceSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: DeviceHandler.instance,
        builder: (context, _) {
          var devices = DeviceHandler.instance.devices;
          var isLoadingDevices = DeviceHandler.instance.isLoadingDevices;
          var currentDevice = DeviceHandler.instance.currentDevice;
          return Row(
            children: [
              devices.isEmpty
                  ? const Text("No Devices Found")
                  : DropdownButton(
                      value: currentDevice,
                      items: List.generate(
                          devices.length,
                          (index) => DropdownMenuItem(
                                value: devices[index],
                                child: Text(devices[index].deviceName),
                              )),
                      onChanged: (value) {
                        if (value == null) return;
                        DeviceHandler.instance.setCurrentDevice(value);
                      },
                    ),
              SizedBox.square(
                dimension: 30,
                child:
                    isLoadingDevices ? const CircularProgressIndicator() : null,
              )
            ],
          );
        });
  }
}
