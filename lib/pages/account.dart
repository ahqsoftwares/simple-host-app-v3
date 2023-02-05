import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

import 'account/information.dart';
import "../components/state.dart";
import "../components/design.dart";

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  Map<dynamic, dynamic>? userData = getDataState("user-limit", false);
  int listenerId = 0;
  int called = 0;

  @override
  void initState() {
    super.initState();

    var uid = registerBuild((Map<dynamic, dynamic> data) {
      setState(() {
        userData = data["user-limit"];
        called += 1;
      });
    });

    setState(() {
      listenerId = uid;
    });
  }

  @override
  void dispose() {
    unregisterBuild(listenerId);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 600;

    return Container(
      decoration: boxDecoration(),
      child: ListView(
        children: [
          Information(
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: isScreenWide ? Axis.horizontal : Axis.vertical,
              children: [
                const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 100,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(isScreenWide ? 20 : 0, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: isScreenWide
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    crossAxisAlignment: isScreenWide
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome ${userData?["email"]?.toString().split("@")[0].toUpperCase()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isScreenWide ? 40 : 30,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(isScreenWide ? 2 : 0, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: !isScreenWide
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                              child: SelectableText(
                                '${userData?["email"].toString()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Information(
            child: Flex(
              direction: isScreenWide ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: isScreenWide
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              crossAxisAlignment: isScreenWide
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.trending_up_rounded,
                  color: Colors.white,
                  size: 100,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(isScreenWide ? 20 : 0, 0, 0, 0),
                  child: Column(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
