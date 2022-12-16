import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import "package:loading_animation_widget/loading_animation_widget.dart";

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool show = false;
  bool dark = false;

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (show == false) {
      dark = isDarkMode;
      Timer(const Duration(seconds: 1, milliseconds: 500), () {
        setState(() {
          show = true;
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
              ],
            ),
          ),
        ));
  }
}
