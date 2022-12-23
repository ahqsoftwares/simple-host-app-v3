import 'dart:ui';

import "package:flutter/material.dart";

import "../components/design.dart";

class Servers extends StatefulWidget {
  const Servers({Key? key}) : super(key: key);

  @override
  ServersState createState() => ServersState();
}

class ServersState extends State<Servers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: boxDecoration(),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
      ),
    );
  }
}

class CreateServer extends StatefulWidget {
  const CreateServer({Key? key}) : super(key: key);

  @override
  State<CreateServer> createState() => CreateServerState();
}

class CreateServerState extends State<CreateServer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.9),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
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
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.fill),
        ),
        child: Column(
          children: [Container()],
        ),
      ),
    );
  }
}
