import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/models/game_pieces/rook.dart';

void main() {
  test("when nothing blocking, it stays inside borders", () {
    Rook rook = Rook(notationValue: 'e4', color: PieceColor.white);
    List<String> expected = [
      'd4',
      'c4',
      'b4',
      'a4',
      'f4',
      'g4',
      'h4',
      'e3',
      'e2',
      'e1',
      'e5',
      'e6',
      'e7',
      'e8'
    ];
    List<String> result = rook.getAvailableMoves({});

    expect(result.toSet(), expected.toSet());
  });

  test(
      "when middle of board, 2 white and 1 black pawn blocking, it includes black pawn and excludes white pawns",
      () {
    Rook rook = Rook(notationValue: 'e4', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'c4': Pawn(notationValue: 'c4', color: PieceColor.black),
      'e6': Pawn(notationValue: 'e6', color: PieceColor.white),
      'e3': Pawn(notationValue: 'e3', color: PieceColor.white),
    };

    List<String> expected = ['d4', 'c4', 'e5', 'f4', 'g4', 'h4'];
    List<String> result = rook.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when king is in way, it doesn't return king in moves", () {
    Rook rook = Rook(notationValue: 'e4', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'c4': King(notationValue: 'c4', color: PieceColor.black),
      'e6': Pawn(notationValue: 'e6', color: PieceColor.white),
      'e3': Pawn(notationValue: 'e3', color: PieceColor.white),
    };

    List<String> expected = ['d4', 'e5', 'f4', 'g4', 'h4'];
    List<String> result = rook.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
    assert(!result.contains('g5'));
  });

  test("when in corner, return correct moves", () {
    Rook rook = Rook(notationValue: 'h8', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'f8': King(notationValue: 'f8', color: PieceColor.white),
      'h6': Pawn(notationValue: 'h6', color: PieceColor.white),
    };

    List<String> expected = ['g8', 'h7'];
    List<String> result = rook.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });
}
