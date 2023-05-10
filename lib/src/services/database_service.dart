import 'dart:convert';
import 'dart:math';

import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/game_board.dart';

class Database {
  final SupabaseClient client = Supabase.instance.client;
  late int id;
  late dynamic subscribed;

  Future<void> createNewGame() async {
    printGreen("DB: Creating new game");

    // TODO: should to extra check if present, add if not
    String? myUUID = await getUUID();
    GameBoard board = GameBoard();
    String randomStart = Random().nextInt(2) == 0 ? 'white_id' : 'black_id';

    Pawn pawn = Pawn(notationValue: 'f3', color: PieceColor.white);
    Pawn pawn2 = Pawn(notationValue: 'd3', color: PieceColor.white);
    board.setGamePieces({'f3': pawn, 'd3': pawn2});

    print("{"
        "$randomStart: $myUUID,"
        "db_game_board: ${board.gamePieces}"
        "}");

    Map<String, dynamic> params = {
      randomStart: myUUID,
      "db_game_board": jsonEncode(board.toJson())
    };

    List<dynamic> returnedList = await client.from('GAMEROOMS').upsert(params).select('game_id');
    id = returnedList.first["game_id"];
    // subscribeToChannel();
    await createStream();
  }

  Future<dynamic> joinRoom() async {
    var rooms = await getAvailableRooms();
    printWarning('FROM DB $rooms');
    if (rooms.length == 0) {
      return Future.error('NO AVAILABLE ROOMS TO PLAY. CREATE ONE!');
    }
    int available_room = rooms[rooms.length - 1]['game_id'];
    printWarning('ROOM TO JOIN: $available_room');
    await joinToSelectedRoom(available_room);
    return available_room;
  }

  Future<List<dynamic>> getAvailableRooms() async {
    return await client.from('GAMEROOMS').select('game_id').is_('black_id', null);
  }

  Future<void> joinToSelectedRoom(int room) async {
    String? myUUID = await getUUID();
    await client.from('GAMEROOMS').update({'black_id': myUUID}).eq('game_id', room);
  }

  // Stream createStream() {
  //   return client.from('GAMEROOMS').stream(primaryKey: ['game_id']).eq('game_id', id);
  // }

  Stream createStream() async* {
    client.from('GAMEROOMS').stream(primaryKey: ['game_id']).eq('game_id', id).listen((event) {
      print("STREAM : ${event}");
    });
  }

  subscribeToChannel(){
    client.channel('GAMEROOMS').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: 'public'),
          (payload, [ref]) {
        print('Change received: ${payload.toString()}');
      },
    ).subscribe();
  }
}

Database db = Database();
