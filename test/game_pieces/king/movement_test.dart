import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/models/game_pieces/queen.dart';

void main() {
  test("when nothing blocking, it  shows available moves around", () {
    King king = King(notationValue: 'd2', color: PieceColor.white);
    List<String> expected = ['c3', 'd3', 'e3', 'c2', 'e2', 'c1', 'd1', 'e1'];

    List<String> result = king.getAvailableMoves({});

    expect(result.toSet(), expected.toSet());
  });

  test("when nothing blocking, but queen other side, it doesn't include those tiles", () {
    King king = King(notationValue: 'e1', color: PieceColor.white);
    List<String> expected = ['e2', 'f2', 'f1'];
    Map<String, GamePiece> gamePieces = {
      'd8': Queen(notationValue: 'd8', color: PieceColor.black)
    };

    List<String> result = king.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when own pieces blocking, it won't include pieces", () {
    King king = King(notationValue: 'e1', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'e4': Pawn(notationValue: 'e4', color: PieceColor.white),
      'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
      'f2': Pawn(notationValue: 'f2', color: PieceColor.white),
      'd1': Queen(notationValue: 'd1', color: PieceColor.white),
    };

    List<String> expected = ['e2', 'f1'];
    List<String> result = king.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });
  test("when corner, it stays inside borders", () {
    King king = King(notationValue: 'h1', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {};

    List<String> expected = ['h2', 'g2', 'g1'];
    List<String> result = king.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });
}
