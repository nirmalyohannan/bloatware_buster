import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:bloatware_buster/model/app_list_filter.dart';
import 'package:flutter/material.dart';

class AppListFilterSelector extends StatelessWidget {
  const AppListFilterSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
      ),
      child: ListenableBuilder(
          listenable: DeviceHandler.instance,
          builder: (context, _) {
            return DropdownButton<AppListFilter>(
              underline: const SizedBox.shrink(),
              value: DeviceHandler.instance.appListFilter,
              items: AppListFilter.values
                  .map((e) => DropdownMenuItem(
                      value: e, child: Text(filterToString(e))))
                  .toList(),
              onChanged: (e) {
                DeviceHandler.instance.setAppListFilter(e);
              },
            );
          }),
    );
  }
}
