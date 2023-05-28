import '../../constants.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class Bishop implements GamePiece {
  late String name = 'BISHOP';
  late PieceColor color;
  late String notationValue;

  late Map<String, GamePiece> _pieces;
  late List<String> _moves = [];

  Bishop({required this.notationValue, required this.color});

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move(String moveTo) {
    // TODO: implement move
  }

  Bishop.fromJson(Map<String, dynamic> json) {
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
  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    _pieces = gamePieces;
    printWarning('Clicked $notationValue');
    List<List<int>> directions = [
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
    if (isOutsideOfGrid(currentTile) || _pieces[currentTile]?.color == PieceColor.black) return;
    String nextTile =
        "${notationLetters[currentTile.index() + dir[0]]}${currentTile.number() + dir[1]}";
    if (_pieces[nextTile]?.color == PieceColor.white || !_pieces.isNotKing(nextTile)) return;

    _moves.add(nextTile);
    calculateMoves(dir, nextTile);
  }

  bool isOutsideOfGrid(String currentTile) {
    return currentTile.index() < 1 ||
        currentTile.number() < 2 ||
        currentTile.index() > 6 ||
        currentTile.number() > 7;
  }

// void calcLeftDecreasingMoves(String currentTile) {
//   if (isOutsideOfGrid(currentTile)) return;
//   String nextTile = "${notationLetters[currentTile.index() - 1]}${currentTile.number() - 1}";
//   if (_pieces[nextTile]?.color == PieceColor.white) return;
//   _moves.add(nextTile);
//   calcLeftDecreasingMoves(nextTile);
// }
//
// void calcLeftIncreasingMoves(String currentTile) {
//   if (isOutsideOfGrid(currentTile)) return;
//   String nextTile = "${notationLetters[currentTile.index() - 1]}${currentTile.number() + 1}";
//   if (_pieces[nextTile]?.color == PieceColor.white) return;
//   _moves.add(nextTile);
//   calcLeftIncreasingMoves(nextTile);
// }
//
// void calcRightDecreasingMoves(String currentTile) {
//   if (isOutsideOfGrid(currentTile)) return;
//   String nextTile = "${notationLetters[currentTile.index() + 1]}${currentTile.number() - 1}";
//   if (_pieces[nextTile]?.color == PieceColor.white) return;
//   _moves.add(nextTile);
//   calcRightDecreasingMoves(nextTile);
// }
//
// void calcRightIncreasingMoves(String currentTile) {
//   if (isOutsideOfGrid(currentTile)) return;
//   String nextTile = "${notationLetters[currentTile.index() + 1]}${currentTile.number() + 1}";
//   if (_pieces[nextTile]?.color == PieceColor.white) return;
//   _moves.add(nextTile);
//   calcRightIncreasingMoves(nextTile);
// }
}
