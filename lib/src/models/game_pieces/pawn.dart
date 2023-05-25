import 'package:replaceAppName/src/constants.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'game_piece_interface.dart';

class Pawn implements GamePiece {
  late String name = 'PAWN';
  late PieceColor color;
  late String notationValue;
  late Map<String, GamePiece> _pieces;
  late final int _moveCalcHelper = color == PieceColor.white ? 1 : -1;
  bool isFirstMove = true;

  int get notationLetterIndex => notationLetters.indexOf(notationValue.letter());

  Pawn({required this.notationValue, required this.color});

  Pawn.fromJson(Map<String, dynamic> json) {
    color = PieceColorFunc.fromJson(json['color']);
    notationValue = json['notationValue'];
    isFirstMove = json['isFirstMove'];
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color.name,
        'notationValue': notationValue,
        'isFirstMove': isFirstMove,
      };

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move(String moveTo) {
    isFirstMove = false;
    notationValue = moveTo;
  }

  // TODO: REFACTO
  @override
  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    _pieces = gamePieces;
    printWarning('Clicked $notationValue');
    int moveCount = isFirstMove ? 2 : 1;
    return calculateMoves([], notationValue, moveCount);
  }

  List<String> calculateMoves(List<String> moves, String currentTile, int moveCount) {
    int nextRowNumber = currentTile.number() + _moveCalcHelper;
    String nextTile = '${notationValue.letter()}$nextRowNumber';

    if (moveCount == 0 || _pieces[nextTile] != null) {
      // check and add enemies last
      getDiagonals().forEach((diagonal) {
        GamePiece? piece = _pieces[diagonal];
        if (piece != null && piece.color != color && _pieces.isNotKing(diagonal)) {
          moves.add(piece.notationValue);
        }
      });
      return moves;
    }

    moves.add(nextTile);
    return calculateMoves(moves, nextTile, moveCount - 1);
  }

  List<String> getDiagonals() {
    int nextRowNumber = notationValue.number() + _moveCalcHelper;
    List<String> diagonals = [];

    if (notationLetterIndex > 0) {
      diagonals.add('${notationLetters[notationLetterIndex - 1]}$nextRowNumber');
    }

    if (notationLetterIndex < 7) {
      diagonals.add('${notationLetters[notationLetterIndex + 1]}$nextRowNumber');
    }
    return diagonals;
  }
}
