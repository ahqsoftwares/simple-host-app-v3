import 'dart:async';
import 'dart:math';

import 'package:simplehostmobile/pages/server/components/console_gauges.dart';

import "./components/console.dart";

import 'package:flutter/material.dart';

class Console extends StatefulWidget {
  const Console({Key? key}) : super(key: key);

  @override
  ConsoleState createState() => ConsoleState();
}

class ConsoleState extends State<Console> {
  String powerState = ""; //stopped, restarting, running;
  List<String> logs = [];

  double number = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(
        const Duration(
          seconds: 1,
        ), (timer) {
      var numbers = Random().nextInt(100);
      print(numbers);
      setState(() {
        number = numbers.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              mainAxisAlignment: width <= 500
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    onPressed: (powerState != "stopped" && powerState == "")
                        ? null
                        : () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        (powerState != "stopped" && powerState == "")
                            ? Colors.green[200]
                            : Colors.green[900],
                      ),
                      fixedSize:
                          MaterialStatePropertyAll(Size((width - 30) / 3, 40)),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        (powerState != "restarting" && powerState != "")
                            ? Colors.blue[900]
                            : Colors.blue[200],
                      ),
                      fixedSize:
                          MaterialStatePropertyAll(Size((width - 30) / 3, 40)),
                    ),
                    onPressed: (powerState != "restarting" && powerState != "")
                        ? () {}
                        : null,
                    child: const Text(
                      "Reboot",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        (powerState == "stopped" || powerState == "")
                            ? Colors.red[300]
                            : Colors.red[900],
                      ),
                      fixedSize: MaterialStatePropertyAll(
                        Size((width - 30) / 3, 40),
                      ),
                    ),
                    onPressed: (powerState == "stopped" || powerState == "")
                        ? null
                        : () {},
                    child: const Text(
                      "Stop",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ConsoleBox(
            logs: logs,
          ),
          ConsoleGauges(
            serverId: "serverId",
            userId: "userId",
            token: "token",
            number: number,
          ),
        ],
      ),
    );
  }
}
