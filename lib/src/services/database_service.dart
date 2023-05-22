import 'dart:convert';
import 'dart:math';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/game_board.dart';

Database db = Database();

class Database {
  final SupabaseClient client = Supabase.instance.client;
  late int id;

  late dynamic subscribed;

  get table => client.from('GAMEROOMS');

  // TODO: REFACTOR
  Future<String> createNewGame() async {
    printDB("DB: Creating new game");

    String? myUUID = await getUUID();
    String myColor = Random().nextInt(2) == 0 ? 'white' : 'black';
    String jsonPieces = jsonEncode(GameBoard().toJson());
    Map<String, dynamic> params = {myColor: myUUID, "db_game_board": jsonPieces};

    Map<String, dynamic> data = await table.insert(params).select().single();
    id = data['game_id'];
    printDB("DB: room $id");

    return myColor;
  }

  Future<dynamic> joinRoom() async {
    printDB("DB: Joining game");

    String? myUUID = await getUUID();
    List<dynamic> rooms = await getAvailableRooms();
    if (rooms.isEmpty) return;
    id = rooms.first['game_id'];

    String availableColor = await getAvailableColor();
    Map<String, dynamic> params = {availableColor: myUUID};

    await table.update(params).eq('game_id', id);

    return availableColor;
  }

  Future<void> updateGamePieces(GameBoard board, String otherPlayerTurnColor) async {
    printDB("DB: UPDATEING GAMEPIECES");

    // TODO: currently only gamePieces are mapped, not GameBoard Object(change ??)
    final jsonPieces = jsonEncode(board.toJson());

    Map<String, dynamic> updateParams = {
      "db_game_board": jsonPieces,
      "current_turn": otherPlayerTurnColor
    };

    await table.update(updateParams).eq('game_id', id);
  }

  Future<void> deleteOrUpdateRoom(String? myColor) async {
    Map<String, dynamic> data = await table.select().eq('game_id', id).single();
    printDB("DB: deleteOrUpdateRoom > data : $data");
    Map<String, dynamic> updateParams = {};
    if (myColor != null) {
      updateParams = {myColor: null};
    }
    printDB("DB: deleteOrUpdateRoom > updateParams : $updateParams");

    await table.update(updateParams).eq('game_id', id);
  }

  Future<List<dynamic>> getAvailableRooms() async {
    List<dynamic> rooms = await table.select('*').or('black.is.null,white.is.null');

    printDB("DB: available rooms > $rooms");
    return rooms;
  }

  Stream createStream() {
    return table.stream(primaryKey: ['game_id']).eq('game_id', id);
  }

  Future<String> getAvailableColor() async {
    Map<String, dynamic> json = await table.select('*').eq('game_id', id).single();
    return json['white'] == null ? 'white' : 'black';
  }

  //  FOR TESTING
  Future<void> resetPieces() async {
    GameBoard board = GameBoard();
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
