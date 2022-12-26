import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:simplehostmobile/pages/login.dart';

import "pages/account.dart";
import "pages/servers.dart";
import "pages/settings.dart";

import "data/api/mod.dart";
import 'components/database.dart';
import "components/state.dart";
import "components/loading.dart";

/*
void useAds(AdRequest request) {
  InterstitialAd.load(
    adUnitId: "ca-app-pub-9599761542257130/7875846393",
    request: request,
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) {
            ad.show().then((_) {}).catchError((_) {});
          },
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, _) {
            ad.dispose();
          },
        );
      },
      onAdFailedToLoad: (_) {},
    ),
  );
}
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  state();

  //if (defaultTargetPlatform == TargetPlatform.android) {
  //MobileAds.instance.initialize();
  //var request = const AdRequest();
  //useAds(request);
  //}

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int current = 0;
  int authenticated = 0; //0: waiting, 1: no, 2: yes
  Map<String, dynamic> userData = {
    "name": "",
    "servers": [],
  };

  @override
  void initState() {
    super.initState();

    updateMe((online) {
      int auth = 0;
      if (online) {
        auth = 2;
      } else {
        auth = 1;
      }
      if (auth != authenticated) {
        setState(() {
          authenticated = auth;
        });
      }
    });

    verifyExisting();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/bg.png"), context);
    return authenticated == 0
        ? const Loading(key: Key("Loading"))
        : authenticated == 1
            ? const Login()
            : MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Simple Host",
                theme: ThemeData.light(),
                home: Scaffold(
                  body: current == 0
                      ? const Servers()
                      : current == 1
                          ? const Account()
                          : const Settings(),
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.905),
                    selectedItemColor: Colors.cyan,
                    unselectedItemColor: Colors.white,
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.storage_rounded),
                        label: "Servers",
                        backgroundColor: Colors.red[600],
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: "Account",
                        backgroundColor: Colors.green[600],
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.settings),
                        label: "Settings",
                        backgroundColor: Colors.blue[600],
                      )
                    ],
                    iconSize: 24,
                    currentIndex: current,
                    onTap: ((value) {
                      setState(() {
                        current = value;
                      });
                    }),
                  ),
                ),
              );
  }
}
