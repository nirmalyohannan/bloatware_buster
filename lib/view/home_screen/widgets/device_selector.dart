import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey.shade400),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.devices),
                    const SizedBox(width: 10),
                    devices.isEmpty
                        ? const Text("No Devices Found")
                        : DropdownButton(
                            isExpanded: false,
                            isDense: true,
                            underline: const SizedBox.shrink(),
                            value: currentDevice,
                            items: List.generate(
                                devices.length,
                                (index) => DropdownMenuItem(
                                      value: devices[index],
                                      child: Text(devices[index].deviceName ??
                                          devices[index].serialNumber),
                                    )),
                            onChanged: (value) {
                              if (value == null) return;
                              DeviceHandler.instance.setCurrentDevice(value);
                            },
                          ),
                  ],
                ),
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
