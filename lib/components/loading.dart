import 'dart:async';

import "../data/theme.dart";
import "package:flutter/material.dart";
import "package:loading_animation_widget/loading_animation_widget.dart";

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
  bool dark = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Host V3",
      theme: theme(),
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
                      color: const Color.fromRGBO(0, 168, 232, 1),
                      size: 200,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
