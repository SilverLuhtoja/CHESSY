import '../../constants.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class Rook implements GamePiece {
  late String name = 'ROOK';
  late PieceColor color;
  late String notationValue;
  late Map<String, GamePiece> _pieces;
  late List<String> _moves = [];

  Rook({required this.notationValue, required this.color});

  Rook.fromJson(Map<String, dynamic> json) {
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

  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    _pieces = gamePieces;
    printWarning('Clicked $notationValue');
    List<List<int>> directions = [
      [-1, 0],
      [1, 0],
      [0, 1],
      [0, -1]
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
    if (_pieces[nextTile]?.color == PieceColor.white || !_pieces.isNotKing(nextTile)) return;

    _moves.add(nextTile);
    calculateMoves(dir, nextTile);
  }

  bool isNextTileOutsideBorders(String currentTile, List<int> dir) {
    int letterVal = currentTile.index() + dir[0];
    int numberVal = currentTile.number() + dir[1];
    return letterVal >= 0 && letterVal < 8 && numberVal > 0 && numberVal < 9;
  }
}
