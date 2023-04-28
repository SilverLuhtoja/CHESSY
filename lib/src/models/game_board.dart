class GameBoard {
  late List<List<Tile>> gameBoard;
  final List<String> _notationLetters = [
    'a',
    'b',
    'c',
    'd',
    'f',
    'g',
    'h',
    'i'
  ];

  GameBoard() {
    gameBoard = generateBoard(8);
  }

  List<List<Tile>> generateBoard(int gridSize) {
    List<List<Tile>> tiles = [];
    bool startWhite = true;

    for (int row = 1; row < gridSize + 1; row++) {
      List<Tile> singleRowOfTiles = [];
      generateRow(gridSize,startWhite, row, singleRowOfTiles);
      tiles.add(singleRowOfTiles);
      startWhite = !startWhite;
    }
    return tiles;
  }

  void generateRow(int gridSize, bool startWhite, int row, List<Tile> singleRowOfTiles) {
    bool isWhite = startWhite;
    for (int column = 0; column < gridSize; column++) {
      String notationValue =
          "${_notationLetters[column]}${gridSize + 1 - row}";
      singleRowOfTiles.add(Tile(row, column, isWhite, notationValue));
      isWhite = !isWhite;
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
