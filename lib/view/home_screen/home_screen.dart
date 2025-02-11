import 'package:bloatware_buster/logic/adb_handler.dart';
import 'package:bloatware_buster/logic/console_handler.dart';
import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:bloatware_buster/model/app_model.dart';
import 'package:bloatware_buster/view/home_screen/widgets/app_card.dart';
import 'package:bloatware_buster/view/home_screen/widgets/app_list_filter_selector.dart';
import 'package:bloatware_buster/view/home_screen/widgets/device_selector.dart';
import 'package:bloatware_buster/view/widgets/container_shadow.dart';
import 'package:bloatware_buster/view/widgets/hover_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AdbHandler.instance
        .findAdbPath()
        .then((value) => DeviceHandler.instance.getConnectedDevices());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 65,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [containerShadow]),
            child: Row(
              children: [
                buildScanDevicesButton(),
                const SizedBox(width: 20),
                const DeviceSelector(),
                const AppListFilterSelector(),
                const AppCountWidget()
              ],
            ),
          ),
          const Flexible(
            child: Row(
              children: [AppListView(), ConsoleView()],
            ),
          )
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

class AppCountWidget extends StatelessWidget {
  const AppCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DeviceHandler.instance,
      builder: (context, child) {
        //Show total installed and uninstalled apps
        var currentDevice = DeviceHandler.instance.currentDevice;
        if (currentDevice == null) return const SizedBox();
        int installedCount = currentDevice.apps
            .where((element) => element.isRemoved == false)
            .length;
        int uninstalledCount = currentDevice.apps
            .where((element) => element.isRemoved == true)
            .length;
        TextStyle titleStyle =
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
        TextStyle valueStyle =
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

        return Container(
          height: 50,
          margin: const EdgeInsets.only(left: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [containerShadow],
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Apps",
                    style: titleStyle.copyWith(color: Colors.green),
                  ),
                  Text(installedCount.toString(), style: valueStyle),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 1,
                color: Colors.grey,
                height: 40,
              ),
              Column(
                children: [
                  Text("Removed",
                      style: titleStyle.copyWith(color: Colors.redAccent)),
                  Text(
                    uninstalledCount.toString(),
                    style: valueStyle,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class ConsoleView extends StatefulWidget {
  const ConsoleView({super.key});

  @override
  State<ConsoleView> createState() => _ConsoleViewState();
}

class _ConsoleViewState extends State<ConsoleView> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          HoverContainer(
            color: Colors.black26,
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(10)),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: SizedBox(
                height: double.infinity,
                child: AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isExpanded ? 0.5 : 0.0,
                    child: const Icon(Icons.arrow_left)),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: isExpanded ? size.width * 0.4 : 0,
              // height: size.height * 0.5,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: ListenableBuilder(
                  listenable: ConsoleHandler.instance,
                  builder: (context, _) {
                    var console = ConsoleHandler.instance;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                            color: Colors.white,
                            onPressed: () => console.clearLog(),
                            child: const Text("Clear Console")),
                        const SizedBox(height: 10),
                        Flexible(
                          child: ListView.builder(
                            itemCount: console.logList.length,
                            itemBuilder: (context, index) {
                              var text = console.logList[index];
                              return Text('>> $text',
                                  style: const TextStyle(color: Colors.white));
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
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
            var currentDevice = DeviceHandler.instance.currentDevice;
            // var isLoadingAppList = DeviceHandler.instance.isLoadingAppList;
            // if (isLoadingAppList) return const SizedBox();

            if (appList == null || appList.isEmpty) {
              return Center(
                  child: Text(
                currentDevice == null ? "No Device Selected" : "No Apps Found",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ));
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
                      suffixIcon: ValueListenableBuilder(
                          valueListenable: searchController,
                          builder: (context, value, child) {
                            if (value.text.isEmpty) {
                              return const Icon(Icons.search);
                            }
                            return IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                  searchTerm = "";
                                });
                              },
                            );
                          }),
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
    searchTerm = searchTerm.toLowerCase();
    searchFilteredList = appList.where((element) {
      return element.packageName.contains(searchTerm) ||
          element.appName?.toLowerCase().contains(searchTerm) == true;
    }).toList();
  }
}
