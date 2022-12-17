import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'components/database.dart';
import "components/state.dart";
import "components/loading.dart";

void main() {
  init();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int current = 0;
  int authenticated = 0; //0: waiting, 1: no, 2: yes
  Map<String, dynamic> userData = {
    "name": "",
    "userName": "",
    "servers": [],
    "account": {
      "email": "",
    },
  };

  @override
  void initState() {
    super.initState();
    registerBuild((data) {
      setState(() {
        if (current == 1) {
          current = 0;
        } else {
          current = 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return current == 0
        ? const Loading(key: Key("Loading"))
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Simple Host",
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
            home: Scaffold(
              appBar: AppBar(
                title: const Text("Simple Host"),
              ),
              body: Text(current.toString()),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: current == 0
                    ? Colors.red[600]
                    : current == 1
                        ? Colors.green[600]
                        : Colors.blue[600],
                unselectedItemColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.computer),
                    label: "Servers",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Account",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Settings",
                  )
                ],
                iconSize: 24,
                currentIndex: current,
                onTap: ((value) {
                  setState(() {
                    current = value;
                  });
                }),
              ),
            ),
          );
  }
}
