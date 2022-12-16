class StateManager {
  Map<String, dynamic> state = {};

  void setState(String key, dynamic value) {
    state.update(
      key,
      (value) => value,
      ifAbsent: () => null,
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

var manager = StateManager();

var callbacks = <Function>[];

void registerBuild(Function callback) {
  callbacks.add(callback);
}

void setDataState(String key, String value) {
  manager.setState(key, value);
  for (var function in callbacks) {
    function(manager.getAll());
  }
}

dynamic getDataState(String key, bool integer) {
  return manager.getState(key, integer);
}
