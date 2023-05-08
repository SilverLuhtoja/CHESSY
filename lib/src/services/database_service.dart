import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/helpers.dart';
import '../widgets/show_snackbar.dart';

class Database {
  final SupabaseClient client = Supabase.instance.client;

  Future<void> createNewGame() async {
    String? myUUID = await getUUID();
    await client.from('GAMEROOMS').upsert({'white_id': myUUID});
  }

  Future<List<dynamic>> getAvailableRooms() async {
    return await client.from('GAMEROOMS').select('game_id').is_('black_id', null);
  }

  Future<void> joinToSelectedRoom(int room) async {
    String? myUUID = await getUUID();
    await client.from('GAMEROOMS').update({'black_id': myUUID}).eq('game_id', room);
  }

  Future<void> joinRoom() async {
    var rooms = await getAvailableRooms();
    printWarning('FROM DB $rooms');
    if (rooms.length == 0) {
      return Future.error('NO AVAILABLE ROOMS TO PLAY. CREATE ONE!');
    }
    int available_room = rooms[0]['game_id'];
    printWarning('ROOM TO JOIN: $available_room');
    await joinToSelectedRoom(available_room);
  }
}

Database db = Database();
