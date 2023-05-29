import 'package:flutter/cupertino.dart';
import '../utils/helpers.dart';
import 'game_pieces/bishop.dart';
import 'game_pieces/game_piece_interface.dart';
import 'game_pieces/king.dart';
import 'game_pieces/knight.dart';
import 'game_pieces/pawn.dart';
import 'game_pieces/queen.dart';
import 'game_pieces/rook.dart';

class GameBoard {
  late List<List<Tile>> gameBoard = generateBoard(8);
  late Map<String, GamePiece> gamePieces = {};
  final List<String> _notationLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  GameBoard() {
    placeGamePiecesToBoard(PieceColor.white);
    placeGamePiecesToBoard(PieceColor.black);
  }

  GameBoard.fromJson(Map<String, dynamic> json) {
    for (dynamic piece in json.entries) {
      switch (piece.value['name']) {
        case 'PAWN':
          gamePieces[piece.key] = Pawn.fromJson(piece.value);
          break;
        case 'KNIGHT':
          gamePieces[piece.key] = Knight.fromJson(piece.value);
          break;
        case 'BISHOP':
          gamePieces[piece.key] = Bishop.fromJson(piece.value);
          break;
        case 'ROOK':
          gamePieces[piece.key] = Rook.fromJson(piece.value);
          break;
        case 'QUEEN':
          gamePieces[piece.key] = Queen.fromJson(piece.value);
          break;
      }
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    for (final entry in gamePieces.entries) {
      map[entry.key] = entry.value.toJson();
    }

    return map;
  }

  Iterable<Tile> get flatGrid => gameBoard.expand((e) => e);

  void setGamePieces(Map<String, GamePiece> pieces) => gamePieces = pieces;

  List<List<Tile>> generateBoard(int gridSize) {
    List<List<Tile>> tiles = [];
    bool startWhite = true;

    for (int row = 1; row < gridSize + 1; row++) {
      List<Tile> singleRowOfTiles = [];
      generateRow(gridSize, startWhite, row, singleRowOfTiles);
      tiles.add(singleRowOfTiles);
      startWhite = !startWhite;
    }
    return tiles;
  }

  void generateRow(int gridSize, bool startWhite, int row, List<Tile> singleRowOfTiles) {
    bool isWhite = startWhite;
    for (int column = 0; column < gridSize; column++) {
      String notationValue = "${_notationLetters[column]}${gridSize + 1 - row}";
      singleRowOfTiles.add(Tile(row, column, isWhite, notationValue));
      isWhite = !isWhite;
    }
  }

  void placeGamePiecesToBoard(PieceColor color) {
    for (int i = 0; i < 8; i++) {
      String rowNumber = color == PieceColor.white ? '2' : '7';
      String value = "${_notationLetters[i]}$rowNumber";
      gamePieces[value] = Pawn(notationValue: value, color: color);
    }
    for (int i = 0; i < 8; i++) {
      String rowNumber = color == PieceColor.white ? '1' : '8';
      String value = "${_notationLetters[i]}$rowNumber";
      switch (i) {
        case 0:
        case 7:
          gamePieces[value] = Rook(notationValue: value, color: color);
          break;
        case 1:
        case 6:
          gamePieces[value] = Knight(notationValue: value, color: color);
          break;
        case 2:
        case 5:
          gamePieces[value] = Bishop(notationValue: value, color: color);
          break;
        case 3:
          gamePieces[value] = Queen(notationValue: value, color: color);
          break;
        // case 4:
        //   gamePieces[value] = King(notationValue: value, color: color);
        //   break;
      }
    }
  }

  // seems repeating (something is fishy)
  void moveGamePiece(String moveFrom, String moveTo) {
    GamePiece? copy = gamePieces[moveFrom];
    gamePieces.remove(moveFrom);
    if (copy != null) {
      copy.move(moveTo);
      gamePieces[moveTo] = copy;
      return;
    }
    throw ErrorDescription("GameBoard: Couldn't find key in GamePieces");
  }
}

class Tile {
  late int row;
  late int column;
  late bool isWhite;
  late String notationValue; // 'g5', 'a1'

  Tile(this.row, this.column, this.isWhite, this.notationValue);
}
