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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(25, 25, 24, 1),
            title: TabBar(
              /*backgroundColor: const Color.fromRGBO(25, 25, 24, 1),*/
              labelColor: Colors.cyan,
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
          body: Column(
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
    );
  }
}
