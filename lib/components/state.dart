import 'dart:async';
import 'package:flutter/foundation.dart';

import "../data/api/mod.dart";

class StateManager {
  Map<String, dynamic> state = {};

  void setState(String key, dynamic value) {
    state.update(
      key,
      (value) => value,
      ifAbsent: () => value,
    );
  }

  dynamic getState(String key, bool integer) {
    if (state.containsKey(key)) {
      return state[key];
    } else {
      if (integer) {
        return 0;
      } else {
        return null;
      }
    }
  }

  Map<String, dynamic> getAll() {
    return state;
  }
}

int uid = 0;

var manager = StateManager();

var callbacks = [];

void state() {
  Timer.periodic(const Duration(seconds: kIsWeb ? 8 : 5), (_) async {
    try {
      var data = await fetchServers();
      setDataState("user-servers", data);
    } catch (_) {}
  });
}

int registerBuild(Function callback) {
  callbacks.add({"call": callback, "uid": uid + 1});
  uid += 1;
  return uid;
}

void unregisterBuild(int buildId) {
  callbacks.retainWhere((element) => element["uid"] != buildId);
}

void setDataState(String key, dynamic value) {
  manager.setState(key, value);

  var data = manager.getAll();
  for (var function in callbacks) {
    function["call"](data);
  }
}

dynamic getDataState(String key, bool integer) {
  return manager.getState(key, integer);
}
