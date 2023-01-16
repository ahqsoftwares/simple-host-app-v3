import "package:flutter/material.dart";

class Server extends StatefulWidget {
  const Server({Key? key}) : super(key: key);

  @override
  ServerState createState() => ServerState();
}

class ServerState extends State<Server> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppBar(
        title: const Text("Server Data"),
      ),
    );
  }
}
