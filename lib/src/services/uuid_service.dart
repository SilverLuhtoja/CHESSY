import 'package:replaceAppName/src/utils/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// TODO: REFACTOR
Future<String?> getUUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("client_uuid") == null) {
    await createUUID();
  }
  return prefs.getString("client_uuid");
}

Future createUUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? prefs_uuid = prefs.getString("client_uuid");
  String uuid = Uuid().v1();

  if (prefs_uuid == null) prefs.setString("client_uuid", uuid);
  // await prefs.remove("client_uuid");

  printGreen("Prefs_UUID: $prefs_uuid");
}
