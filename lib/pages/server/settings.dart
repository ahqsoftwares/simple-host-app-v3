import 'package:flutter/material.dart';
import 'package:simplehostmobile/pages/server/components/settings_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SettingsWidget(
          child: InkWell(
            child: const Text("Hi"),
            onTap: () {},
          ),
        )
      ],
    );
  }
}
