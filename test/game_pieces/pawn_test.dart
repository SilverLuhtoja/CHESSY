import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';

void main() {
  Pawn pawn = Pawn(notationValue: 'e2', color: PieceColor.white);

  test("when first move and nothing blocking, it shows 2 available moves", () {
    Map<String, GamePiece> gamePieces = {};

    List<String> expected = ['e3', 'e4'];
    List<String> result = pawn.getAvailableMoves(gamePieces);

    expect(result, expected);
  });

  test("when first move and gamePiece on way, it shows 1 available move", () {
    Map<String, GamePiece> gamePieces = {
      'e4': Pawn(notationValue: 'e4', color: PieceColor.white),
    };

    List<String> expected = ['e3'];
    List<String> result = pawn.getAvailableMoves(gamePieces);

    expect(result, expected);
  });

  test("when first move and gamePiece on way, it shows 0 available move", () {
    Map<String, GamePiece> gamePieces = {
      'e3': Pawn(notationValue: 'e3', color: PieceColor.white),
    };

    List<String> expected = [];
    List<String> result = pawn.getAvailableMoves(gamePieces);

    expect(result, expected);
  });

  test("when first move and enemy in vicinity, it shows 3 available moves", () {
    Map<String, GamePiece> gamePieces = {
      'f3': Pawn(notationValue: 'f3', color: PieceColor.black),
    };

    List<String> expected = ['e3', 'e4', 'f3'];
    List<String> result = pawn.getAvailableMoves(gamePieces);

    expect(result, expected);
  });

  test("when first move and enemy is 2 tiles away, it shows 2 available moves", () {
    Map<String, GamePiece> gamePieces = {
      'f4': Pawn(notationValue: 'f4', color: PieceColor.black),
    };

    List<String> expected = ['e3', 'e4'];
    List<String> result = pawn.getAvailableMoves(gamePieces);

    expect(result, expected);
  });

  test("when no first move and enemy in vicinity, it shows 2 available moves", () {
    pawn.isFirstMove = false;
    Map<String, GamePiece> gamePieces = {
      'f3': Pawn(notationValue: 'f3', color: PieceColor.black),
    };

    List<String> expected = ['e3', 'f3'];
    List<String> result = pawn.getAvailableMoves(gamePieces);

    expect(result, expected);
  });
}
