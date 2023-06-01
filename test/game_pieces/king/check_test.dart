import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_pieces/bishop.dart';
import 'package:replaceAppName/src/models/game_pieces/bishop.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/knight.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/models/game_pieces/queen.dart';
import 'package:replaceAppName/src/models/game_pieces/rook.dart';

void main() {
  group('PAWN check', () {
    test("when no threat, it is false", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e4': Pawn(notationValue: 'e4', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
    test("when pawn diagonally to king, it is true", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'c2': Pawn(notationValue: 'c2', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, true);
    });
    test("when pawn next to king, it is false", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'd2': Pawn(notationValue: 'd2', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
  });

  group('KNIGHT check', () {
    test("when no threat, it is false", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'd3': Knight(notationValue: 'd3', color: PieceColor.white),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
    test("when knight in range, it is true", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'b2': Knight(notationValue: 'b2', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, true);
    });
    test("when knight in range, it is true", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e3': Knight(notationValue: 'e3', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, true);
    });
  });

  group('QUEEN check', () {
    test("when no threat, it is false", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'h5': Queen(notationValue: 'h5', color: PieceColor.black),
        'e2': Pawn(notationValue: 'e2', color: PieceColor.white),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
    test("when knight in range, it is true", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'a4': Queen(notationValue: 'a4', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, true);
    });
  });

  group('BISHOP check', () {
    test("when no threat, it is false", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'h5': Bishop(notationValue: 'h5', color: PieceColor.black),
        'e2': Pawn(notationValue: 'e2', color: PieceColor.white),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
    test("when knight in range, it is true", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'a4': Bishop(notationValue: 'a4', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, true);
    });
  });

  group('ROOK check', () {
    test("when no threat, it is false", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'd8': Rook(notationValue: 'd8', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, true);
    });
    test("when knight in range, it is true", () {
      King king = King(notationValue: 'd1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'a4': Rook(notationValue: 'a4', color: PieceColor.black),
      };
      bool result = king.isUnderCheck(gamePieces);
      expect(result, false);
    });
  });
}
