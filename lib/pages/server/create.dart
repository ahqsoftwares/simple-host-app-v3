import 'dart:async';

import "package:flutter/material.dart";

import 'package:simplehostmobile/data/api/mod.dart';
import "../../components/state.dart";

class CreateServer extends StatefulWidget {
  const CreateServer({Key? key}) : super(key: key);

  @override
  State<CreateServer> createState() => CreateServerState();
}

class CreateServerState extends State<CreateServer> {
  double width = 0;
  double height = 0;
  String submitText = "Submit";
  String status = "Submit";
  String servername = "";

  bool skip = false;

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

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 52, 89),
      ),
      home: Scaffold(
        bottomNavigationBar: !skip
            ? Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 52, 89),
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
              )
            : Container(
                height: 50,
              ),
        body: Container(
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "Server Name",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      hintText: "Enter new server name",
                      icon: width >= 250
                          ? const Icon(
                              Icons.storage,
                            )
                          : null,
                    ),
                    initialValue: servername,
                    onSaved: (value) {
                      setState(() {
                        servername = value as String;
                      });
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please enter a server name";
                      } else if (value.contains(" ")) {
                        return "No spaces";
                      } else if (value.length > 32) {
                        return "Please be short";
                      }
                      bool red = false;
                      for (var char = 0; char < value.length; char++) {
                        String chh = value[char];
                        if (chh.toLowerCase() == chh.toUpperCase()) {
                          red = true;
                        }
                      }

                      if (red) {
                        return "Only letters are allowed!";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 80,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (status == "Submit") {
                        setState(() {
                          status = "Busy";
                        });
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            skip = true;
                          });
                          formKey.currentState!.save();
                          Timer(const Duration(milliseconds: 200), () {
                            setState(() {
                              submitText = "Checking";
                            });
                            makeServer(servername).then((_) async {
                              setState(() {
                                submitText = "Done!";
                              });
                              await state();
                              void pop() {
                                Navigator.pop(context);
                              }

                              pop();
                            }).catchError((_) {
                              setState(() {
                                submitText = "Error";
                              });
                              Timer(const Duration(seconds: 2), () {
                                setState(() {
                                  submitText = "Submit";
                                  status = "Submit";
                                  servername = "";
                                  skip = false;
                                });
                              });
                            });
                          });
                        }
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
                              ? submitText == "Done!"
                                  ? Colors.green[500]
                                  : Colors.red[500]
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
        ),
      ),
    );
  }
}
