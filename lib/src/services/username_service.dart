import 'package:shared_preferences/shared_preferences.dart';


Future<String?> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("username") == null) {
    await saveUsername('NO USERNAME');
  }
  return prefs.getString("username");
}

Future saveUsername(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("username", username);
}
