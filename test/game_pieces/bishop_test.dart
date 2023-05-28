import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/bishop.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';

void main() {
  Bishop bishop = Bishop(notationValue: 'f4', color: PieceColor.white);

  test("when middle of board, 2 white and 1 black pawn blocking, it shows 7 available moves", () {
    Map<String, GamePiece> gamePieces = {
      'h2': Pawn(notationValue: 'h2', color: PieceColor.white),
      'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
      'c7': Pawn(notationValue: 'c7', color: PieceColor.black),
    };

    List<String> expected = ['e3', 'g3', 'e5', 'd6', 'c7', 'g5', 'h6'];
    List<String> result = bishop.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });

  // test("when my pieces, it shows 1 available moves", () {
  //   Map<String, GamePiece> gamePieces = {
  //     'd2': Pawn(notationValue: 'd2', color: PieceColor.white),
  //   };
  //
  //   // List<String> expected = ['g3', 'h2', 'g5' , 'h6'];
  //   List<String> expected = [ 'e3' ];
  //   List<String> result = bishop.getAvailableMoves(gamePieces);
  //
  //   expect(result.toSet(), expected.toSet());
  // });

  test("when nothing blocking, it shows 11 available moves", () {
    Map<String, GamePiece> gamePieces = {
    };

    List<String> expected = ['e3', 'd2', 'c1', 'g3', 'h2', 'e5', 'd6', 'c7', 'b8', 'g5', 'h6'];
    List<String> result = bishop.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });
  //
  test("when only right side moves, it shows 4 available moves", () {
    Map<String, GamePiece> gamePieces = {
      'c7': Pawn(notationValue: 'c7', color: PieceColor.black)
    };

    List<String> expected = ['e5', 'd6', 'g5', 'h6'];
    // List<String> expected = [ 'g5' , 'h6'];
    List<String> result = bishop.getAvailableMoves(gamePieces);

    expect(result.toSet(), expected.toSet());
  });
}
