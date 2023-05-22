import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// flutter pub run build_runner build
@GenerateNiceMocks([MockSpec<Database>()])
import 'package:replaceAppName/src/services/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateNiceMocks([MockSpec<Random>()])
import 'dart:math';

import 'db_test.mocks.dart';


//  TODO: ONHOLD
void main() async {
  Database subject = MockDatabase();
  Random  random  = MockRandom();
  final SupabaseClient client = Supabase.instance.client;
  setUp((){
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({"client_uuid" : "UUID"});
    when(random.nextInt(2)).thenReturn(0);
    when(subject.table).thenReturn(client.from('GAMEROOMS'));
  });

  test("When creating new game and everything OK, it send correct data and returns player color",
      () async {
    GameBoard board = GameBoard();
    board.gamePieces = {'a2': Pawn(notationValue: 'a2', color: PieceColor.white)};
    Map<String, dynamic> board_pieces = {
      'a2': {'instance': 'PAWN', 'color': 'white', 'notationValue': 'a2', 'isFirstMove': true}
    };
    String? futureUUID =  await getUUID();
    Map<String, dynamic> expected_params = {'white': futureUUID, 'db_game_board': board_pieces};
    // when(random.nextInt(2)).thenReturn(0);

    String value = await subject.createNewGame();
    expect(futureUUID, "UUID");
    expect(board.toJson(), board_pieces);

    subject.createNewGame();
    verify(subject.table.upsert(expected_params));
  });
}
