import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/knight.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';

void main() {
  test("when nothing is blocking movement, it shows all 8 available moves", () {
    Knight knight = Knight(notationValue: 'e3', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {};

    List<String> expected = ['d1', 'f1', 'c2', 'c4', 'd5', 'f5', 'g4', 'g2'];
    List<String> result = knight.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when near the left edge of grid, it shows 4 available moves", () {
    Knight knight = Knight(notationValue: 'b2', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {};

    List<String> expected = ['a4', 'c4', 'd3', 'd1'];
    List<String> result = knight.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when near the down right  corner of grid, it shows 2 available moves", () {
    Knight knight = Knight(notationValue: 'h1', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {};

    List<String> expected = ['g3', 'f2'];
    List<String> result = knight.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when knight checks KING, it wont show this as available move", () {
    Knight knight = Knight(notationValue: 'h1', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'g3': King(notationValue: 'g3', color: PieceColor.black),
    };

    List<String> expected = ['f2', 'g3'];
    List<String> result = knight.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when enemy pieces and my pieces are in way, it shows 3 available moves", () {
    Knight knight = Knight(notationValue: 'f3', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'h2': Pawn(notationValue: 'h2', color: PieceColor.white),
      'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
      'd4': Pawn(notationValue: 'd4', color: PieceColor.white),
      'e1': Pawn(notationValue: 'e1', color: PieceColor.white),
      'e5': Pawn(notationValue: 'e5', color: PieceColor.black),
      'g1': Pawn(notationValue: 'g1', color: PieceColor.white),
      'h4': Pawn(notationValue: 'h4', color: PieceColor.black),
    };

    List<String> expected = ['e5', 'g5', 'h4'];
    List<String> result = knight.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });
}
