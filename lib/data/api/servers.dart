import 'dart:convert';

import "package:http/http.dart";

Future<List<Map<String, dynamic>>> getServers(
    String uid, String pwd, String host) async {
  return await get(
    Uri(
      host: host,
      scheme: "https",
      path: "client/servers",
    ),
    headers: {
      "x-uid": uid,
      "x-pwd": pwd,
    },
  ).then((response) {
    List<Map<String, dynamic>> datas = [];

    var payload = jsonDecode(response.body) as List;

    for (var data in payload) {
      var status = data["State"];

      if (status["Running"]) {
        status = "Running";
      } else if (status["Paused"]) {
        status = "Paused";
      } else if (status["Restarting"]) {
        status = "Restarting";
      } else if (status["OOMKilled"] ||
          status["Dead"] ||
          status["Status"] == "created") {
        status = "Stopped";
      } else {
        status = "Unknown";
      }
      datas.add(
        {
          "name": (data["Name"] as String).replaceFirst("/", ""),
          "status": status,
        },
      );
    }

    return datas;
  }).catchError((_) {
    return [{}] as dynamic;
  });
}
