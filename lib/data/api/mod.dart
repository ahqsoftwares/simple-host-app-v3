import 'dart:convert';

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import "../../components/database.dart";

import "servers.dart";

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

Future<dynamic> fetchUser() async {
  if (!loggedIn) {
    throw ErrorSummary("User is not logged in!");
  }
  return await http.get(
    Uri(
      host: host,
      path: "client/me",
      scheme: "https",
    ),
    headers: {"x-uid": userId, "x-pwd": password},
  ).then((response) {
    return jsonDecode(response.body);
  }).catchError((_) {});
}

Future<void> makeServer(String name) async {
  return await createServer(userId, password, host, name);
}

Future<void> rmServer(String name) async {
  return await deleteServer(userId, password, host, name);
}

Future<List<Map<String, dynamic>>> fetchServers() async {
  if (!loggedIn) {
    throw ErrorSummary("User is not logged in!");
  }
  return await getServers(userId, password, host);
}

Future<bool> verifyExisting() async {
  if (kIsWeb) {
    host = "simple-host-core.dfshbdgfbgfnfghgndbfgr.repl.co";
  }

  userId = getData("x-uid");
  password = getData("x-password");

  if (userId == "" || password == "") {
    changeLoggedInStatus(false);
    return false;
  }

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
      var mockPassword = jsonDecode(response.body).toString();
      if (mockPassword != "Ok") {
        password = mockPassword;
      }
      changeLoggedInStatus(true);
    } else {
      changeLoggedInStatus(false);
    }
  }).catchError((e) {
    // ignore: avoid_print
    print(e);
    changeLoggedInStatus(false);
  });

  return loggedIn;
}
