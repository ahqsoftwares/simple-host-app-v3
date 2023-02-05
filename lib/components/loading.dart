import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simplehostmobile/components/state.dart';

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
  bool updateAvailable = false;
  bool show = false;
  bool dark = true;

  @override
  void initState() {
    super.initState();

    Future<void> checkForUpdates() async {
      bool updateAvailableRn = false;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      var currentVersion = "v${packageInfo.version}+${packageInfo.buildNumber}";

      await get(
        Uri(
          host: "api.github.com",
          scheme: "https",
          path: !kIsWeb && Platform.isWindows
              ? "repos/ahqsoftwares/ahq-store-data/commits"
              : "repos/ahqsoftwares/simple-host-app-v3/releases/latest",
        ),
      ).then((response) async {
        if (!kIsWeb && Platform.isWindows) {
          var body = jsonDecode(response.body)[0]?["sha"].toString();

          await get(
            Uri(
              host: "rawcdn.githack.com",
              scheme: "https",
              path:
                  'ahqsoftwares/ahq-store-data/$body/database/C3J2k2OnXv7ZfvFAnyYv.json',
            ),
          ).then((data) async {
            var version = jsonDecode(data.body)?["version"]?.toString();

            updateAvailableRn = currentVersion != version;
          }).catchError((_) async {
            updateAvailableRn = false;
          });
        } else if (!kIsWeb) {
          var version = jsonDecode(response.body)["tag_name"]?.toString();

          updateAvailableRn = currentVersion != version;
        } else {
          updateAvailableRn = false;
        }
      }).catchError((_) {
        updateAvailableRn = false;
      });

      setDataState("update", updateAvailableRn ? "2" : "1");
      setState(() {
        updateAvailable = updateAvailableRn;
      });
    }

    checkForUpdates().catchError((_) {
      setDataState("update", "1");
      setState(() {
        updateAvailable = false;
      });
    });

    Timer(const Duration(seconds: 2), () {
      try {
        setState(() {
          show = true;
        });
      } catch (_) {}
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
              const Text(
                "Simple Host",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Bequest",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color.fromRGBO(0, 168, 232, 1),
                      size: 200,
                    )
                  : Container(),
              Text(
                updateAvailable ? "Update Available" : "",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Bequest",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
