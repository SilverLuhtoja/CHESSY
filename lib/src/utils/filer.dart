import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'helpers.dart';

const String file_name = 'game_data.txt';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/$file_name').create(recursive: true);
}

Future<File> writeFile(String value) async {
  // printWarning("WRITING");

  final file = await _localFile;
  return file.writeAsString(value);
}

Future<String> readFile() async {
  // printWarning("READING");

  try {
    final file = await _localFile;
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    initFileData("Some value");
    printError(e.toString());
    printError("ERROR: Can not return $file_name content");
    return "";
  }
}

void initFileData(String value) {
  writeFile(value);
  readFile();
}
