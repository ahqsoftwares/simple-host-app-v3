import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:simplehostmobile/pages/login.dart';

import "pages/account.dart";
import "pages/servers.dart";
import 'pages/store.dart';

import "data/api/mod.dart";
import 'components/database.dart';
import "components/state.dart";
import "components/loading.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  state();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  late TabController _tabController;

  int limit = getDataState("user-limit", false) == null
      ? 0
      : getDataState("user-limit", false)!["slots"];

  int count = getDataState("user-servers", false) == null
      ? 0
      : getDataState("user-servers", false)!.length;

  int authenticated = 0; //0: waiting, 1: no, 2: yes
  int update = 1; //0: waiting; 1: no; 2: yes
  Map<String, dynamic> userData = {
    "name": "",
    "servers": [],
  };

  @override
  void initState() {
    super.initState();
    double width =
        (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *
                80) /
            100;

    _tabController = TabController(
      length: 3,
      animationDuration:
          width > 500 ? kTabScrollDuration : const Duration(milliseconds: 125),
      vsync: this,
    );

    registerBuild((data) {
      var updateAvailable = int.parse(data["update"].toString());

      setState(() {
        count = data["user-servers"].length;
        limit = data["user-limit"]["slots"];
        update = updateAvailable;
      });
    });

    updateMe((online) {
      int auth = 0;

      if (online) {
        auth = 2;
      } else {
        auth = 1;
      }
      if (auth != authenticated) {
        void set() {
          setState(() {
            authenticated = auth;
          });
        }

        if (auth == 2) {
          Timer.periodic(const Duration(seconds: 1), (timer) {
            var data = getDataState("user-servers", false);
            if (data != null) {
              set();
              timer.cancel();
            }
          });
        } else {
          set();
        }
      }
    });

    verifyExisting();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/bg.png"), context);
    return (authenticated == 0 || update == 0 || update == 2)
        ? const Loading(key: Key("Loading"))
        : authenticated == 1
            ? const Login()
            : MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Simple Host",
                theme: ThemeData.light(),
                home: Scaffold(
                  backgroundColor: const Color.fromRGBO(25, 25, 24, 1),
                  body: TabBarView(
                    controller: _tabController,
                    children: const [
                      Servers(),
                      Account(),
                      MarketPlace(),
                    ],
                  ),
                  bottomNavigationBar: TabBar(
                    labelColor: Colors.cyan,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      const Tab(
                        icon: Icon(Icons.storage_rounded),
                        text: "Servers",
                      ),
                      Tab(
                        icon: Badge(
                          smallSize: count >= (limit * 0.75) ? 10 : 0,
                          child: const Icon(Icons.account_circle_rounded),
                        ),
                        text: "Account",
                      ),
                      const Tab(
                        icon: Icon(Icons.storefront),
                        text: "Market",
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
              );
  }
}
