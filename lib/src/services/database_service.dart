import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Database {
  final SupabaseClient client = Supabase.instance.client;

  Future<void> createNewGame() async {
    printGreen("DB: Creating new game");
    String? myUUID = await getUUID();
    await client.from('GAMEROOMS').upsert({'white_id': myUUID});
  }
}

Database db = Database();
