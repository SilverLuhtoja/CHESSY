import 'package:shared_preferences/shared_preferences.dart';


Future<String?> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("username");
}

Future saveUsername(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("username", username);
}

//for testing
void deleteUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("username", '');
}