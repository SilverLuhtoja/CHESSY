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

Database db = Database();

class Database {
  final SupabaseClient client = Supabase.instance.client;
  late int id = 91;
  late dynamic subscribed;

  get table => client.from('GAMEROOMS');

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
    // await table.upsert(params);
    return myColor == 'white_id' ? 'white' : 'black';
  }

  Future<dynamic> joinRoom() async {
    List<dynamic> rooms = await getAvailableRooms();
    if (rooms.isEmpty) return;
    printDB("DB: set database id to > ${rooms[0]['game_id']}");
    id = rooms.first['game_id'];

    String availableSlot = await getAvailableSlot();
    printDB("DB: available slot > $availableSlot");

    // TODO: should to extra check if UUID is present, add if not
    String? myUUID = await getUUID();
    Map<String, dynamic> params = {availableSlot: myUUID};
    await table.upsert(params);
    return availableSlot == 'white_id' ? 'white' : 'black';
  }

  Future<List<dynamic>> getAvailableRooms() async {
    dynamic rooms = await table.select('*').or('black_id.is.null,white_id.is.null');
    printDB("DB: available rooms > $rooms");
    return rooms;
  }

  Future<void> updateGamePieces(GameBoard board, String otherPlayerTurnColor) async {
    printDB("DB: UPDATEING GAMEPIECES");
    printDB("DB: ${board.gamePieces}");
    // currently only gamePieces are mapped, not GameBoard Object(change ??)
    final jsonPieces = jsonEncode(board.toJson());

    Map<String, dynamic> updateParams = {
      "db_game_board": jsonPieces,
      "current_turn": otherPlayerTurnColor
    };

    await table.update(updateParams).eq('game_id', id);
    printDB("DB: UPDATE DONE");
  }

  Stream createStream() {
    return table.stream(primaryKey: ['game_id']).eq('game_id', id);
  }

  Future<String> getAvailableSlot() async {
    dynamic json = await table.select('*').eq('game_id', id).single();
    printDB("DB: current room  > ${json['white_id']}");
    return json['white_id'] == null ? 'white_id' : 'black_id';
  }

  //  FOR TESTING
  void resetPieces(GameBoard board) async {
    Pawn pawn = Pawn(notationValue: 'e7', color: PieceColor.black);
    Pawn pawn2 = Pawn(notationValue: 'd2', color: PieceColor.white);
    board.setGamePieces({'e7': pawn, 'd2': pawn2});
    final jsonPieces = jsonEncode(board.toJson());
    printDB("DB: $jsonPieces");
    await table.update({"db_game_board": jsonPieces}).eq('game_id', id);
  }
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
