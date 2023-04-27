class GameBoard {
  late List<List<Tile>> gameBoard;

  GameBoard() {
    this.gameBoard = generateBoard(8);
  }

  List<List<Tile>> generateBoard(int gridSize) {
    List<List<Tile>> tiles = [];
    bool isWhite = true;
    for (int row = 1; row < gridSize + 1; row++) {
      List<Tile> singleRowOfTiles = [];
      isWhite = !isWhite;
      for (int column = 0; column < gridSize; column++) {
        isWhite = !isWhite;
        singleRowOfTiles.add(Tile(row, column, isWhite));
      }
      tiles.add(singleRowOfTiles);
    }
    return tiles;
  }
}

class Tile {
  late int row;
  late int column;
  late bool isWhite;

  Tile(this.row, this.column, this.isWhite);

  get alphaValue{
      // List<String> values = ['a', 'b', 'c', 'd', 'f', 'g', 'h', 'i'].toList()[column];
      return ['a', 'b', 'c', 'd', 'f', 'g', 'h', 'i'].toList()[column];
  }
}
