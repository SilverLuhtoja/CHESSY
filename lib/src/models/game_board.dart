import 'game_piece.dart';

class GameBoard {
  late List<List<Tile>> gameBoard;
  final Map<String, GamePiece> gamePieces = {};
  final List<String> _notationLetters = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
  ];

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
    return tiles;
  }

  void generateRow(
      int gridSize, bool startWhite, int row, List<Tile> singleRowOfTiles) {
    bool isWhite = startWhite;
    for (int column = 0; column < gridSize; column++) {
      String notationValue = "${_notationLetters[column]}${gridSize + 1 - row}";
      GamePiece? occupancyValue =
          placeGamePieceToBoard(row, column, notationValue);
      singleRowOfTiles.add(Tile(row, column, isWhite, notationValue,
          occupancyValue != null, occupancyValue, false));
      isWhite = !isWhite;
    }
  }

  GamePiece? placeGamePieceToBoard(int row, int column, String notationValue) {
    if (row == 7) {
      gamePieces[notationValue] = Pawn(
        notationValue: notationValue,
        color: PieceColor.white,
      );
    }
    if (row == 2) {
      gamePieces[notationValue] = Pawn(
        notationValue: notationValue,
        color: PieceColor.black,
      );
    }
    return gamePieces[notationValue];
  }
}

class Tile {
  late int row;
  late int column;
  late bool isWhite;
  late String notationValue; // 'g5', 'a1'
  late bool occupied;
  late GamePiece? occupancyValue;
  late bool openForMove;

  Tile(this.row, this.column, this.isWhite, this.notationValue, this.occupied,
      this.occupancyValue, this.openForMove);
}
