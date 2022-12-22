import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import "../../components/database.dart";

List<Function> callbacks = [];

String userId = "";
String password = "";

String host = "api.simplehost.ml";
bool loggedIn = false;

void changeLoggedInStatus(bool status) {
  loggedIn = status;

  if (status) {
    setData("x-uid", userId);
    setData("x-password", password);
  }

  for (var element in callbacks) {
    element(status);
  }
}

Future<bool> verifyExisting() async {
  if (kIsWeb) {
    host = "simple-host-core.dfshbdgfbgfnfghgndbfgr.repl.co";
  }

  userId = getData("x-uid");
  password = getData("x-password");

  return await verify();
}

void updateMe(Function callback) {
  callbacks.add(callback);
}

void setUser(String uid, String pwd) {
  userId = uid;
  password = pwd;
}

Future<bool> verify() async {
  print(''''$userId, $password''');
  await http
      .get(
    Uri(host: host, scheme: "https", path: "client/"),
    headers: Map<String, String>.from(
      {
        "x-uid": userId,
        "x-pwd": password,
      },
    ),
  )
      .then((response) {
    if (response.statusCode == 200) {
      changeLoggedInStatus(true);
    } else {
      changeLoggedInStatus(false);
    }
  }).catchError((e) {
    changeLoggedInStatus(false);
  });

  return loggedIn;
}
