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
      var status = data["state"];

      if (status["running"]) {
        status = "Running";
      } else if (status["paused"]) {
        status = "Paused";
      } else if (status["restarting"]) {
        status = "Restarting";
      } else if (status["OOMKilled"] ||
          status["dead"] ||
          status["status"] == "created") {
        status = "Stopped";
      } else {
        status = "Unknown";
      }
      datas.add(
        {
          "name": (data["name"] as String).replaceFirst("/", ""),
          "status": status,
          "resources": {
            "cpu": data["resources"]["cpu"] as String,
            "ram": data["resources"]["ram"] as String,
            "ramUsage": data["resources"]["ramUsage"] as String,
            "network": data["resources"]["network"] as String
          }
        },
      );
    }
    return datas;
  }).catchError((_) {
    return [{}] as List<Map<String, dynamic>>;
  });
}

Future<void> createServer(
    String uid, String pwd, String host, String servername) async {
  await post(
    Uri(
      host: host,
      path: "client/server/new",
      scheme: "https",
    ),
    headers: {
      "x-uid": uid,
      "x-pwd": pwd,
      "x-servername": servername,
    },
  ).then((value) {
    if (value.statusCode != 200) {
      throw Error();
    }
  }).catchError((_) {
    throw Error();
  });
}

Future<void> deleteServer(
    String uid, String pwd, String host, String servername) async {
  await delete(
    Uri(
      host: host,
      path: "client/server/delete",
      scheme: "https",
    ),
    headers: {
      "x-uid": uid,
      "x-pwd": pwd,
      "x-servername": servername,
    },
  ).then((value) {
    if (value.statusCode != 200) {
      throw Error();
    }
  }).catchError((_) {
    throw Error();
  });
}
