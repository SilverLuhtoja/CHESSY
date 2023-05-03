import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:replaceAppName/src/App.dart';
import 'package:replaceAppName/src/client_server.dart/client.dart';

Future<void> main() async {
  // client.initializeConnection();

  // firebase
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(App());
}
