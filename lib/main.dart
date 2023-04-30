import 'package:flutter/material.dart';
import 'package:replaceAppName/src/App.dart';
import 'package:replaceAppName/src/client_server.dart/client.dart';

// void main() => runApp(App());
Future<void> main() async {
  client.initializeConnection();

  runApp(App());
}
