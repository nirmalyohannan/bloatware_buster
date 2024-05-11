import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:bloatware_buster/model/app_model.dart';
import 'package:bloatware_buster/view/home_screen/widgets/app_card.dart';
import 'package:bloatware_buster/view/home_screen/widgets/app_list_filter_selector.dart';
import 'package:bloatware_buster/view/home_screen/widgets/device_selector.dart';
import 'package:bloatware_buster/view/widgets/hover_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    DeviceHandler.instance.getConnectedDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const DeviceSelector(),
              buildScanDevicesButton(),
              const AppListFilterSelector()
            ],
          ),
          const AppListView(),
        ],
      ),
    );
  }

  TextButton buildScanDevicesButton() {
    return TextButton.icon(
        onPressed: () => DeviceHandler.instance.getConnectedDevices(),
        icon: const Icon(Icons.refresh),
        label: const Text("Scan Devices"));
  }
}

class AppListView extends StatefulWidget {
  const AppListView({
    super.key,
  });

  @override
  State<AppListView> createState() => _AppListViewState();
}

class _AppListViewState extends State<AppListView> {
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  List<AppModel> searchFilteredList = [];
  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListenableBuilder(
          listenable: DeviceHandler.instance,
          builder: (context, _) {
            var appList = DeviceHandler.instance.currentDevice?.apps;
            // var isLoadingAppList = DeviceHandler.instance.isLoadingAppList;
            // if (isLoadingAppList) return const SizedBox();
            if (appList == null || appList.isEmpty) {
              return const Text("No Apps Found");
            }

            return Column(
              children: [
                HoverContainer(
                  isFocused: searchFocusNode.hasFocus,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            searchTerm = "";
                          });
                        },
                      ),
                    ),
                    onTap: () => setState(() {}),
                    onTapOutside: (event) => setState(() {
                      searchFocusNode.unfocus();
                    }),
                    onChanged: (value) => setState(() {
                      searchTerm = value;
                    }),
                  ),
                ),
                Flexible(
                  child: Builder(builder: (context) {
                    searchFilter(appList);
                    if (searchFilteredList.isEmpty) {
                      return const Text("No Apps Found in Search");
                    }
                    return ListView.builder(
                        itemCount: searchFilteredList.length,
                        itemBuilder: (context, index) {
                          var app = searchFilteredList[index];
                          return AppCard(app: app);
                        });
                  }),
                ),
              ],
            );
          }),
    );
  }

  void searchFilter(List<AppModel> appList) {
    searchFilteredList = appList.where((element) {
      return element.packageName.contains(searchTerm);
    }).toList();
  }
}
