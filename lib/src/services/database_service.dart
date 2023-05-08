import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Database {
  final SupabaseClient client = Supabase.instance.client;

  Future<void> createNewGame() async {
    String? myUUID = await getUUID();
    await client.from('GAMEROOMS').upsert({'white_id': myUUID});
  }
}

Database db = Database();
