import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/game_pieces/game_piece_interface.dart';
import '../providers/game_provider.dart';
import '../utils/helpers.dart';
import '../widgets/show_snackbar.dart';

class Database {
  final SupabaseClient client = Supabase.instance.client;

  Future<dynamic> createNewGame() async {
    String? myUUID = await getUUID();
    return await client.from('GAMEROOMS').upsert({'white_id': myUUID,}).select('game_id');
  }

  Future<List<dynamic>> getAvailableRooms() async {
    return await client.from('GAMEROOMS').select('game_id').is_('black_id', null);
  }

  Future<void> joinToSelectedRoom(int room) async {
    String? myUUID = await getUUID();
    await client.from('GAMEROOMS').update({'black_id': myUUID}).eq('game_id', room);
  }

  Future<dynamic> joinRoom() async {
    var rooms = await getAvailableRooms();
    printWarning('FROM DB $rooms');
    if (rooms.length == 0) {
      return Future.error('NO AVAILABLE ROOMS TO PLAY. CREATE ONE!');
    }
    int available_room = rooms[rooms.length-1]['game_id'];
    printWarning('ROOM TO JOIN: $available_room');
    await joinToSelectedRoom(available_room);
    return available_room;
  }


  Future<void> sendData(String stepBy , String moveFrom, String moveTo, int roomId ) async {
    await  client.from('GAMEROOMS').update({'history': {
      'action_by': stepBy,
      'from': moveFrom,
      'to': moveTo
    }}).eq('game_id', roomId.toString());
  }

  // Future<void> sendData(String stepBy , Map<String, GamePiece> gamePieces, int roomId ) async {
  //   await  client.from('GAMEROOMS').update({'history': gamePieces}).eq('game_id', roomId.toString());
  // }

  Stream createStream(int roomId) {
    return client.from('GAMEROOMS').stream(primaryKey: ['game_id']).eq('game_id', roomId);
  }

}

Database db = Database();
