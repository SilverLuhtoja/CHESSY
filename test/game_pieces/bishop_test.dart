import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/bishop.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';

void main() {
  test("when middle of board, 2 white and 1 black pawn blocking, it shows 7 available moves", () {
    Bishop bishop = Bishop(notationValue: 'f4', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'h2': Pawn(notationValue: 'h2', color: PieceColor.white),
      'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
      'c7': Pawn(notationValue: 'c7', color: PieceColor.black),
    };

    List<String> expected = ['e3', 'g3', 'e5', 'd6', 'c7', 'g5', 'h6'];
    List<String> result = bishop.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when nothing blocking, it shows 11 available moves", () {
    Bishop bishop = Bishop(notationValue: 'f4', color: PieceColor.white);
    List<String> expected = ['e3', 'd2', 'c1', 'g3', 'h2', 'e5', 'd6', 'c7', 'b8', 'g5', 'h6'];
    List<String> result = bishop.getAvailableMoves({});

    expect(result.toSet(), expected.toSet());
  });

  test("when king is in way, it doesn't return king in moves", () {
    Bishop bishop = Bishop(notationValue: 'f4', color: PieceColor.white);
    Map<String, GamePiece> gamePieces = {
      'h2': Pawn(notationValue: 'h2', color: PieceColor.white),
      'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
      'c7': Pawn(notationValue: 'c7', color: PieceColor.black),
      'g5': King(notationValue: 'g5', color: PieceColor.black),
    };

    List<String> expected = ['e3', 'g3', 'e5', 'd6', 'c7', 'g5'];
    List<String> result = bishop.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  test("when in corner, return correct moves", () {
    Bishop bishop = Bishop(notationValue: 'a1', color: PieceColor.white);
    List<String> expected = ['b2', 'c3', 'd4', 'e5', 'f6', 'g7', 'h8'];
    List<String> result = bishop.getAvailableMoves({});

    expect(result.toSet(), expected.toSet());
  });
}
