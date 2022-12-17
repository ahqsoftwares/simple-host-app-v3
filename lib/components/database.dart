import "package:shared_preferences/shared_preferences.dart";

class Database {
  Database(SharedPreferences preferences) : database = preferences;

  SharedPreferences database;

  static Future<Database> create() async {
    var db = await SharedPreferences.getInstance();

    return Database(db);
  }

  String getData(String key) {
    var data = database.getString(key);

    if (data == null) {
      return "";
    } else {
      return data;
    }
  }

  bool hasData(String key) {
    return database.containsKey(key);
  }

  void setData(String key, String value) {
    database.setString(key, value);
  }

  void deleteData(String key) {
    database.remove(key);
  }
}

Database? database;

Future<void> init() async {
  database = await Database.create();
}

void setData(String key, String value) {
  if (database != null) {
    database?.setData(key, value);
  } else {
    throw Error();
  }
}

bool hasData(String key) {
  if (database != null) {
    var output = database?.hasData(key);
    if (output == null) {
      return false;
    } else {
      return output;
    }
  } else {
    throw Error();
  }
}

void removeData(String key) {
  if (database != null) {
    database?.deleteData(key);
  } else {
    throw Error();
  }
}

String getData(String key) {
  if (database != null) {
    var data = database?.getData(key);

    if (data == null) {
      return "";
    } else {
      return data;
    }
  } else {
    throw Error();
  }
}
