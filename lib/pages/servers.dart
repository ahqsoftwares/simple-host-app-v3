import 'dart:async';

import "package:flutter/material.dart";
import 'package:simplehostmobile/data/api/mod.dart';

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
        child: Text(
          '$count servers',
          style: const TextStyle(color: Colors.white),
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

class CreateServer extends StatefulWidget {
  const CreateServer({Key? key}) : super(key: key);

  @override
  State<CreateServer> createState() => CreateServerState();
}

class CreateServerState extends State<CreateServer> {
  double width = 0;
  double height = 0;
  String submitText = "Submit";
  String servername = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      width = (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .width *
              80) /
          100;
      height = (MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .height *
              80) /
          100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Server Name",
                    icon: width >= 250
                        ? const Icon(
                            Icons.storage,
                            color: Colors.white,
                          )
                        : null,
                    iconColor: Colors.white,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    prefixIconColor: Colors.white,
                    suffixIconColor: Colors.white),
                initialValue: servername,
                onSaved: (value) {
                  setState(() {
                    servername = value as String;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please enter a server name";
                  } else if (value.length > 10) {
                    return "Please be short";
                  }
                  return null;
                },
              ),
              Container(
                height: 80,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    Timer(const Duration(milliseconds: 200), () {
                      setState(() {
                        submitText = "Checking";
                      });
                      makeServer(servername).then((_) {
                        setState(() {
                          submitText = "Done!";
                        });
                        Navigator.pop(context);
                      }).catchError((_) {
                        setState(() {
                          submitText = "Error";
                        });
                        Timer(const Duration(seconds: 2), () {
                          setState(() {
                            submitText = "Submit";
                          });
                        });
                      });
                    });
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 60,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      (submitText != "Submit" && submitText != "Checking")
                          ? Colors.red[500]
                          : Colors.blue),
                ),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    submitText,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
