import '../../constants.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class King implements GamePiece {
  late String name = 'KING';
  late PieceColor color;
  late String notationValue;
  late Map<String, GamePiece> _pieces;
  late List<String> _moves = [];
  late bool underAttack;

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

  // get current king spot
  // loop squares like queen
  // Have to check whos currently attacking also (rook cant move diagonally)
  // loop surrounding squares and check for pawns and knights
  // Basically every piece movement to check for opposite colors
  bool isUnderCheck(Map<String, GamePiece> gamePieces) {
    _pieces = gamePieces;
    isCheckFromPawn();
    return underAttack;
  }

  void isCheckFromPawn() {
    int index = notationValue.index();
    int moveCalcHelper = color == PieceColor.white ? 1 : -1;
    int nextRowNumber = notationValue.number() + moveCalcHelper;
    for (int i in [1, -1]) {
      if (index > 0 && index < 7) {
        String diag = '${notationLetters[index - i]}$nextRowNumber';
        if (_pieces[diag]?.name == 'PAWN' && _pieces[diag]?.color != color) {
          underAttack = true;
          return;
        }
      }
    }
    underAttack = false;
  }

// void isCheckFromKnight{
// void isCheckFromQueenAndRook(){
// void isCheckFromQueenAndBishop(){
}
