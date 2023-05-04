import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/App.dart';
import 'package:replaceAppName/src/services/uuid_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await createUUID(); //wait until uuid is created

  runApp(ProviderScope(
    child: App()
  ));
}
