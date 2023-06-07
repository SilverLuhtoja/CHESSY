import 'package:flutter_test/flutter_test.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/king.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/models/game_pieces/queen.dart';
import 'package:replaceAppName/src/models/game_pieces/rook.dart';

void main() {

  group("isGameOver", () {
    test('when king not checked, pawn and king surrounding, it is true', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'e2': Pawn(notationValue: 'e2', color: PieceColor.black),
        'e3': King(notationValue: 'e3', color: PieceColor.black),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, true);
    });

    test('when king not checked, pawn and king surrounding, but my piece can unblock move, it is false', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'e2': Pawn(notationValue: 'e2', color: PieceColor.black),
        'e3': King(notationValue: 'e3', color: PieceColor.black),
        'h2': Queen(notationValue: 'h2', color: PieceColor.white),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, false);
    });


    test('when king under attack and no moves left, but is defendable, it is false', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'a1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'a1': theKing,
        'a8': Rook(notationValue: 'a8', color: PieceColor.black),
        'b8': Queen(notationValue: 'b8', color: PieceColor.black),
        'b1': Queen(notationValue: 'b1', color: PieceColor.white),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, false);
    });

    test('when king under attack and no moves left and is not defendable, it is true', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'a1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'a1': theKing,
        'a8': Rook(notationValue: 'a8', color: PieceColor.black),
        'b8': Queen(notationValue: 'b8', color: PieceColor.black),
        'b1': Rook(notationValue: 'b1', color: PieceColor.white),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, true);
    });


    test('when king under attack, is not defendable but there are still moves left, it is false', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'e2': Queen(notationValue: 'e2', color: PieceColor.black),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, false);
    });

    test('when king under attack, no moves left and not defendable, it is true', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'e2': Queen(notationValue: 'e2', color: PieceColor.black),
        'e8': Rook(notationValue: 'e8', color: PieceColor.black),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, true);
    });

    test('when king under attack, 1 move left, it is false', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'd3': Queen(notationValue: 'd3', color: PieceColor.black),
        'e8': Rook(notationValue: 'e8', color: PieceColor.black),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, false);
    });

    test('when king surrounded 3 sides, no moves left, it is true', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'd8': Rook(notationValue: 'd8', color: PieceColor.black),
        'f8': Rook(notationValue: 'f8', color: PieceColor.black),
        'a2': Queen(notationValue: 'a2', color: PieceColor.black),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, true);
    });

    test('when king checked, it is false', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.white);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'c2': Pawn(notationValue: 'c2', color: PieceColor.black),
        'g3': Rook(notationValue: 'g3', color: PieceColor.black),
        'd2': Queen(notationValue: 'd2', color: PieceColor.black),
      };
      gameBoard.gamePieces = gamePieces;

      final result = gameBoard.isGameOver('white');

      expect(result, false);
    });

    test('when game start, it returns false', () {
      GameBoard gameBoard = GameBoard();
      King theKing = King(notationValue: 'e1', color: PieceColor.black);
      Map<String, GamePiece> gamePieces = {
        'e1': theKing,
        'd8': King(notationValue: 'd8', color: PieceColor.white),
        'e8': Queen(notationValue: 'e8', color: PieceColor.white),
        'd1': Queen(notationValue: 'd1', color: PieceColor.black),
      };
      gameBoard.gamePieces = gamePieces;
      bool result = gameBoard.isGameOver('white');
      expect(result, false);
    });
  });
}
