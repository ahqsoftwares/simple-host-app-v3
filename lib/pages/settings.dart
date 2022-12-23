import "package:flutter/material.dart";

import "../components/design.dart";

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      width = (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .width *
              98) /
          100;
      height = 80;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration(),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(10),
      child: Container(
        height: height,
        width: width,
        decoration: boxOverlayDecoration(),
      ),
    );
  }
}
