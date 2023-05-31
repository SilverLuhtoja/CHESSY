import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/models/game_pieces/queen.dart';

void main() {
  group('PAWN check', () {
    King king = King(notationValue: 'd1', color: PieceColor.white);
    test("when nothing blocking, it  shows available moves around", () {
      Map<String, GamePiece> gamePieces = {
        'e4': Pawn(notationValue: 'e4', color: PieceColor.white),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
    test("when nothing blocking, it  shows available moves around", () {
      Map<String, GamePiece> gamePieces = {
        'c2': Pawn(notationValue: 'c2', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, true);
    });
    test("when nothing blocking, it  shows available moves around", () {
      Map<String, GamePiece> gamePieces = {
        'd2': Pawn(notationValue: 'd2', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
  });
}
