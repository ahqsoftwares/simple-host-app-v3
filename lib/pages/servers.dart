import "package:flutter/material.dart";
import 'package:simplehostmobile/components/server.dart';

import "./server/create.dart";
import "./server/server.dart";

import "../components/state.dart";
import "../components/design.dart";

class Servers extends StatefulWidget {
  const Servers({Key? key}) : super(key: key);

  @override
  ServersState createState() => ServersState();
}

class ServersState extends State<Servers> {
  int limit = getDataState("user-limit", false) == null
      ? 0
      : getDataState("user-limit", false)!["slots"];

  int count = getDataState("user-servers", false) == null
      ? 0
      : getDataState("user-servers", false)!.length;

  int uid = 0;

  @override
  void initState() {
    super.initState();

    int uID = registerBuild((Map<dynamic, dynamic> data) {
      setState(() {
        count = data["user-servers"].length;
        limit = data["user-limit"]["slots"];
      });
    });

    setState(() {
      uid = uID;
    });
  }

  @override
  void dispose() {
    super.dispose();

    unregisterBuild(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: boxDecoration(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        // ignore: sized_box_for_whitespace
        child: Container(
          width: MediaQuery.of(context).size.width * 98 / 100,
          child: ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              try {
                var items = getDataState("user-servers", false);
                var item = items[index];

                return ServerContainer(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const Server(),
                    ));
                  },
                  labelText: item["name"].toString(),
                  status: item["status"].toString(),
                );
              } catch (_) {
                return const InkWell();
              }
            },
          ),
        ),
      ),
      floatingActionButton: count < limit
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateServer(),
                  ),
                );
              },
              backgroundColor: Colors.blue[900],
              icon: const Icon(Icons.add),
              label: Text(
                (MediaQuery.of(context).size.width > 300)
                    ? "Create a server"
                    : "Create",
                style: const TextStyle(
                  fontFamily: "Arial",
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
    );
  }
}
