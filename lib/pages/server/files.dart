import "dart:io";
import "dart:convert";
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:file_picker/file_picker.dart";
import "package:path_provider/path_provider.dart";
import "package:flutter/foundation.dart";

import 'package:flutter/material.dart';
import "package:universal_html/js.dart" as js;

const maxBytes = 7340032;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Future<String?> pick() async {
  FilePickerResult? pickedResult = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ["zip"],
    allowMultiple: false,
    lockParentWindow: true,
  );

  return base64Encode(
    File(
      pickedResult!.files.first.path as String,
    ).readAsBytesSync(),
  );
}

Future<void> save(String base64data) async {
  final bytes = base64Decode(base64data);

  if (kIsWeb) {
    js.context.callMethod("save", [base64data]);
  } else if (!Platform.isAndroid && !Platform.isIOS) {
    String? path = await FilePicker.platform.saveFile(
      fileName: "image.zip",
      type: FileType.custom,
      allowedExtensions: ["zip"],
    );

    if (path != null) {
      File(path).writeAsBytesSync(
        bytes,
        mode: FileMode.write,
      );
    }
  } else {
    Directory appDir = await getApplicationDocumentsDirectory();

    var file = File('$appDir/image.zip');

    if (file.existsSync()) {
      String fileName = getRandomString(100);

      File('$appDir/image$fileName.zip').writeAsBytesSync(
        bytes,
        mode: FileMode.write,
      );

      AndroidFlutterLocalNotificationsPlugin().show(
        Random().nextInt(1000),
        "Saved Successfully",
        'Image saved at $appDir/image$fileName.zip',
      );
    } else {
      file.writeAsBytesSync(
        bytes,
        mode: FileMode.write,
      );
    }
  }
}

class Files extends StatefulWidget {
  const Files({Key? key}) : super(key: key);

  @override
  FilesState createState() => FilesState();
}

class FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        pick()
            .then((value) => print(value!.length >= maxBytes))
            .catchError((_) {});
      },
      child: Container(),
    );
  }
}
