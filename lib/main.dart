import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/App.dart';
import 'package:replaceAppName/src/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:replaceAppName/src/services/uuid_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  await createUUID(); //wait until uuid is created

  runApp(ProviderScope(
    child: App()
  ));
}
