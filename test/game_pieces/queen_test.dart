import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/models/game_pieces/queen.dart';

void main() {
  test("when nothing blocking, it stays inside borders", () {
    Queen queen = Queen(notationValue: 'a1', color: PieceColor.white);
    List<String> expected = [
      'a2',
      'a3',
      'a4',
      'a5',
      'a6',
      'a7',
      'a8',
      'b1',
      'c1',
      'd1',
      'e1',
      'f1',
      'g1',
      'h1',
      'b2',
      'c3',
      'd4',
      'e5',
      'f6',
      'g7',
      'h8',
    ];

    List<String> result = queen.getAvailableMoves({});

    expect(result.toSet(), expected.toSet());
  });

  test(
      "when middle of board, 2 white and 1 black pawn blocking, it includes black pawn and excludes white pawns",
      () {
    Queen queen = Queen(notationValue: 'a1', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'c1': Pawn(notationValue: 'c1', color: PieceColor.white),
      'c3': Pawn(notationValue: 'c3', color: PieceColor.black),
      'a3': Pawn(notationValue: 'a3', color: PieceColor.white),
    };

    List<String> expected = ['b2', 'c3', 'a2', 'b1'];
    List<String> result = queen.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when king is in way, it doesn't return king in moves", () {
    Queen queen = Queen(notationValue: 'a1', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'c1': Pawn(notationValue: 'c1', color: PieceColor.white),
      'c3': King(notationValue: 'c3', color: PieceColor.black),
      'a3': Pawn(notationValue: 'a3', color: PieceColor.white),
    };

    List<String> expected = ['b2', 'a2', 'b1', 'c3'];
    List<String> result = queen.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
    assert(!result.contains('g5'));
  });

  test("when all blocked, it gives available moves all directions", () {
    Queen queen = Queen(notationValue: 'b2', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'a4': Pawn(notationValue: 'a4', color: PieceColor.white),
      'b4': Pawn(notationValue: 'b4', color: PieceColor.white),
      'c4': Pawn(notationValue: 'c4', color: PieceColor.white),
      'd4': Pawn(notationValue: 'd4', color: PieceColor.white),
      'd3': Pawn(notationValue: 'd3', color: PieceColor.white),
      'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
      'd1': Pawn(notationValue: 'd1', color: PieceColor.white),
    };

    List<String> expected = ['a3', 'b3', 'c3', 'a2', 'c2', 'a1', 'b1', 'c1'];
    List<String> result = queen.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
    assert(!result.contains('g5'));
  });
}
