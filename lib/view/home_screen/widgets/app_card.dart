import 'package:bloatware_buster/logic/device_handler.dart';
import 'package:bloatware_buster/model/app_model.dart';
import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.app,
  });

  final AppModel app;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  Duration animationDuration = const Duration(milliseconds: 100);
  Duration deleteAnimationDuration = const Duration(milliseconds: 1300);
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) => setState(() {
          isHover = true;
        }),
        onExit: (_) => setState(() {
          isHover = false;
        }),
        child: AnimatedContainer(
          duration: animationDuration,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isHover
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: AnimatedSize(
            curve: Curves.bounceOut,
            duration: deleteAnimationDuration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.app.isRemoved
                      ? Text("${widget.app.packageName} App Removed",
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                      : Row(
                          children: [
                            buildIcon(),
                            const SizedBox(width: 10),
                            Expanded(child: Text(widget.app.packageName)),
                            MaterialButton(
                                splashColor: Colors.red.shade200,
                                hoverColor: Colors.red.shade100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.red)),
                                onPressed: () {
                                  showRemoveConfirmation();
                                },
                                child: const Text("Remove",
                                    style: TextStyle(color: Colors.red))),
                          ],
                        ),
                ),
                // const Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIcon() {
    return AnimatedContainer(
        duration: animationDuration,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: isHover == false
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null),
        child: Image.asset(
          'assets/images/android_icon.png',
          width: 50,
          height: 50,
        ));
  }

  void removeApp() {
    DeviceHandler.instance.removeApp(widget.app, (success) async {
      if (success) {
        setState(() {
          widget.app.isRemoved = true;
        });
        await Future.delayed(deleteAnimationDuration * 2);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to remove app")));
      }
    });
  }

  void showRemoveConfirmation() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Remove App"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Are you sure you want to remove this app?"),
                Text(
                  widget.app.packageName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    removeApp();
                  },
                  child: const Text("Remove")),
            ],
          );
        });
  }
}
