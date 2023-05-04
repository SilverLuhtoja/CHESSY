import 'package:replaceAppName/src/utils/helpers.dart';

import 'game_piece.dart';

class GameBoard {
  late List<List<Tile>> gameBoard;
  final Map<String, GamePiece> gamePieces = {};
  final List<String> _notationLetters = ['a', 'b', 'c', 'd', 'f', 'g', 'h', 'i'];

  GameBoard() {
    gameBoard = generateBoard(8);
  }

  List<List<Tile>> generateBoard(int gridSize) {
    List<List<Tile>> tiles = [];
    bool startWhite = true;

    for (int row = 1; row < gridSize + 1; row++) {
      List<Tile> singleRowOfTiles = [];
      generateRow(gridSize, startWhite, row, singleRowOfTiles);
      tiles.add(singleRowOfTiles);
      startWhite = !startWhite;
    }
    placeGamePieceToBoard(PieceColor.white);
    placeGamePieceToBoard(PieceColor.black);
    return tiles;
  }

  void generateRow(
      int gridSize, bool startWhite, int row, List<Tile> singleRowOfTiles) {
    bool isWhite = startWhite;
    for (int column = 0; column < gridSize; column++) {
      String notationValue = "${_notationLetters[column]}${gridSize + 1 - row}";
      singleRowOfTiles.add(Tile(row, column, isWhite, notationValue));
      isWhite = !isWhite;
    }
  }

  void placeGamePieceToBoard(PieceColor color) {
    for (int i = 0 ; i < 8 ; i++){
      String rowNumber = color == PieceColor.white ? '2' : '7';
      String value = "${_notationLetters[i]}$rowNumber";
      gamePieces[value] =Pawn(notationValue: value, color: color);
    }
    for (int i = 0 ; i < 8 ; i++){
      String rowNumber = color == PieceColor.white ? '1' : '8';
      String value = "${_notationLetters[i]}$rowNumber";
      switch (i){
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
        case 4:
          gamePieces[value] = King(notationValue: value, color: color);
          break;
      }
    }
  }
}

class Tile {
  late int row;
  late int column;
  late bool isWhite;
  late String notationValue; // 'g5', 'a1'

  Tile(this.row, this.column, this.isWhite, this.notationValue);
}
