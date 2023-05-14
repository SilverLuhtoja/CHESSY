import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/main.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/providers/game_provider.dart';
import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_board.dart';

class Database {
  final SupabaseClient client = Supabase.instance.client;
  late int id = 91;
  late dynamic subscribed;

  //  FOR TESTING
  void resetPieces(GameBoard board) async {
    Pawn pawn = Pawn(notationValue: 'e7', color: PieceColor.black);
    Pawn pawn2 = Pawn(notationValue: 'd2', color: PieceColor.white);
    board.setGamePieces({'e7': pawn, 'd2': pawn2});
    final jsonPieces = jsonEncode(board.toJson());
    printDB("DB: $jsonPieces");
    await db.client.from('GAMEROOMS').update({"db_game_board": jsonPieces}).eq('game_id', id);
  }

  // TODO: REFACTOR
  Future<String> createNewGame() async {
    printDB("DB: Creating new game");

    // TODO: should to extra check if UUID is present, add if not
    String? myUUID = await getUUID();
    GameBoard board = GameBoard();
    String myColor = Random().nextInt(2) == 0 ? 'white_id' : 'black_id';

    final jsonPieces = jsonEncode(board.toJson());
    Map<String, dynamic> params = {myColor: myUUID, "db_game_board": jsonPieces};
    printDB(params.toString());

    // resetPieces(board);

    // await client.from('GAMEROOMS').upsert(params);
    return myColor == 'white_id' ? 'white' : 'black';
  }

  Future<void> updateGamePieces(GameBoard board, WidgetRef ref) async {
    printDB("DB: UPDATEING GAMEPIECES");
    printDB("DB: ${board.gamePieces}");
    String? color = ref.watch(gamePiecesStateProvider).myColor;
    String otherPlayerTurnColor = color == 'white' ? 'black' : 'white';

    // currently only gamePieces are mapped, not GameBoard Object(change ??)
    final jsonPieces = jsonEncode(board.toJson());

    Map<String, dynamic> updateParams = {
      "db_game_board": jsonPieces,
      "current_turn": otherPlayerTurnColor
    };

    await db.client.from('GAMEROOMS').update(updateParams).eq('game_id', id);
    printDB("DB: UPDATE DONE");
  }

  Stream createStream() {
    return client.from('GAMEROOMS').stream(primaryKey: ['game_id']).eq('game_id', id);
  }

// Future<dynamic> joinRoom() async {
//   var rooms = await getAvailableRooms();
//   printWarning('FROM DB $rooms');
//   if (rooms.length == 0) {
//     return Future.error('NO AVAILABLE ROOMS TO PLAY. CREATE ONE!');
//   }
//   int available_room = rooms[rooms.length - 1]['game_id'];
//   printWarning('ROOM TO JOIN: $available_room');
//   await joinToSelectedRoom(available_room);
//   return available_room;
// }
//
// Future<List<dynamic>> getAvailableRooms() async {
//   return await client.from('GAMEROOMS').select('game_id').is_('black_id', null);
// }

// Future<void> joinToSelectedRoom(int room) async {
//   String? myUUID = await getUUID();
//   await client.from('GAMEROOMS').update({'black_id': myUUID}).eq('game_id', room);
// }

//   subscribeToChannel() {
//     client.channel('GAMEROOMS').on(
//       RealtimeListenTypes.postgresChanges,
//       ChannelFilter(event: '*', schema: 'public'),
//       (payload, [ref]) {
//         print('Change received: ${payload.toString()}');
//       },
//     ).subscribe();
//   }
//
//   void removeAllSubriptions() {
//     printDB("DB: removing subs");
//     client.removeAllChannels();
//     printDB("All channels : ${client.getChannels()}");
//   }
}

Database db = Database();
