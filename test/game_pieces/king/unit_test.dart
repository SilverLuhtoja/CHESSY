import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/models/game_pieces/queen.dart';

void main() {
  group('getEnemyPieces', () {
    test('when given array of gamepieces, it returns 2 enemy pieces', () {
      King king = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e4': Pawn(notationValue: 'e4', color: PieceColor.white),
        'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
        'f2': Pawn(notationValue: 'f2', color: PieceColor.black),
        'd1': Queen(notationValue: 'd1', color: PieceColor.black),
      };
      Map<String, GamePiece> result = king.sortedPieces(gamePieces);
      expect(result.length, 2);
    });

    test('when given array of gamepieces, it returns enemy piece', () {
      King king = King(notationValue: 'e1', color: PieceColor.black);
      Map<String, GamePiece> gamePieces = {
        'e4': Pawn(notationValue: 'e4', color: PieceColor.white),
        'f2': Pawn(notationValue: 'f2', color: PieceColor.black),
        'd1': Queen(notationValue: 'd1', color: PieceColor.black),
      };
      Map<String, GamePiece> result = king.sortedPieces(gamePieces);
      expect(result.length, 1);
    });
  });
}
