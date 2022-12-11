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
}
