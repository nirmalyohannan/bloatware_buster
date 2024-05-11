import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:bloatware_buster/model/app_list_filter.dart';
import 'package:flutter/material.dart';

class AppListFilterSelector extends StatelessWidget {
  const AppListFilterSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: DeviceHandler.instance,
        builder: (context, _) {
          return DropdownButton<AppListFilter>(
            value: DeviceHandler.instance.appListFilter,
            items: AppListFilter.values
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(filterToString(e))))
                .toList(),
            onChanged: (e) {
              DeviceHandler.instance.setAppListFilter(e);
            },
          );
        });
  }
}
