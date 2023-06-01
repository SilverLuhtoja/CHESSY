import '../../constants.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class King implements GamePiece {
  late String name = 'KING';
  late PieceColor color;
  late String notationValue;
  late Map<String, GamePiece> _pieces;
  late List<String> _moves = [];
  bool underAttack = false;

  King({required this.notationValue, required this.color});

  King.fromJson(Map<String, dynamic> json) {
    color = PieceColorFunc.fromJson(json['color']);
    notationValue = json['notationValue'];
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color.name,
        'notationValue': notationValue,
      };

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move(String moveTo) {
    // TODO: implement move
  }

  @override
  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    _pieces = gamePieces;
    printWarning('Clicked $notationValue');
    List<List<int>> directions = [
      [-1, 0],
      [1, 0],
      [0, 1],
      [0, -1],
      [-1, -1],
      [1, -1],
      [-1, 1],
      [1, 1]
    ];
    for (var dir in directions) {
      calculateMoves(dir, notationValue);
    }
    return _moves;
  }

  void calculateMoves(List<int> dir, String currentTile) {
    if (!isNextTileOutsideBorders(currentTile, dir) ||
        _pieces[currentTile]?.color == PieceColor.black) return;
    String nextTile =
        "${notationLetters[currentTile.index() + dir[0]]}${currentTile.number() + dir[1]}";
    if (_pieces[nextTile]?.color == PieceColor.white) return;

    _moves.add(nextTile);
  }

  bool isNextTileOutsideBorders(String currentTile, List<int> dir) {
    int letterVal = currentTile.index() + dir[0];
    int numberVal = currentTile.number() + dir[1];
    return letterVal >= 0 && letterVal < 8 && numberVal > 0 && numberVal < 9;
  }

  bool isUnderCheck(Map<String, GamePiece> gamePieces) {
    Map<String, GamePiece> newGamePieces = sortedPieces(gamePieces);

    for (final value in newGamePieces.values) {
      List<String> valueMoves = value.getAvailableMoves(gamePieces);
      if (valueMoves.contains(notationValue)) underAttack = true;
    }

    return underAttack;
  }

  Map<String, GamePiece> sortedPieces(Map<String, GamePiece> gamePieces) {
    Map<String, GamePiece> newGamePieces = Map.from(gamePieces)
      ..removeWhere((key, value) => value.color == color);
    // maybe only for testing needed ???
    if (!gamePieces.containsKey(notationValue)) {
      gamePieces[notationValue] = King(notationValue: notationValue, color: color);
    }
    return newGamePieces;
  }
}
