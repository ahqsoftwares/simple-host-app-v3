import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import "package:loading_animation_widget/loading_animation_widget.dart";

const Map<String, double> status = {
  "booting": 0,
  "checking For Updates": 1,
  "update Available": 2,
  "installing Update": 3,
  "checking For Login": 4,
  "loading App": 5
};

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

String toUpperLowerCase(String input) {
  return input[0].toUpperCase() + input.replaceFirst(input[0], "");
}

class _LoadingState extends State<Loading> {
  bool show = false;
  bool dark = false;
  double state = status["booting"] as double;

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (show == false) {
      dark = isDarkMode;
      Timer(const Duration(seconds: 2), () {
        setState(() {
          show = true;
          state = status["checking For Login"] as double;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Simple Host V3",
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: dark
                          ? const AssetImage("assets/dark.png")
                          : const AssetImage("assets/light.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                show
                    ? LoadingAnimationWidget.prograssiveDots(
                        color: dark ? Colors.white : Colors.black,
                        size: 200,
                      )
                    : Container(),
                Container(
                  width: 500,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.lightGreen[800] as Color, width: 5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    toUpperLowerCase(
                      status.keys.firstWhere(
                        (i) => status[i] == state,
                        orElse: () => "Not Found",
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.green[800] as Color,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
