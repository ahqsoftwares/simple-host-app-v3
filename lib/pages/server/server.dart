import "package:flutter/material.dart";

import 'package:simplehostmobile/pages/server/console.dart';
import 'package:simplehostmobile/pages/server/files.dart';
import 'package:simplehostmobile/pages/server/settings.dart';

class Server extends StatefulWidget {
  const Server({Key? key}) : super(key: key);

  @override
  ServerState createState() => ServerState();
}

class ServerState extends State<Server> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    double width =
        (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width *
                80) /
            100;

    _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration:
          width > 500 ? kTabScrollDuration : const Duration(milliseconds: 125),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(25, 25, 24, 1),
            title: TabBar(
              labelColor: Colors.green[500],
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: MediaQuery.of(context).size.width < 500
                  ? const [
                      Tab(icon: Icon(Icons.terminal)),
                      Tab(icon: Icon(Icons.folder)),
                      Tab(icon: Icon(Icons.settings)),
                    ]
                  : const [
                      Tab(text: "Console", icon: Icon(Icons.terminal)),
                      Tab(text: "Files", icon: Icon(Icons.folder)),
                      Tab(text: "Settings", icon: Icon(Icons.settings)),
                    ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg-i.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [Console(), Files(), Settings()],
                  ),
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
