import 'package:flutter/material.dart';
import 'package:replaceAppName/src/App.dart';
import 'package:replaceAppName/src/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(App());
}

// Is Singelton (so no extra will be created,always single instance)
final SupabaseClient client = Supabase.instance.client;
