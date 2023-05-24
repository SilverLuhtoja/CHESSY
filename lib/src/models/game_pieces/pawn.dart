import 'package:replaceAppName/src/constants.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'game_piece_interface.dart';

class Pawn implements GamePiece {
  late String name = 'PAWN';
  late PieceColor color;
  late String notationValue;
  bool isFirstMove = true;

  late final int _moveCalcHelper = color == PieceColor.white ? 1 : -1;

  String get letter => notationValue.substring(0, 1);

  int get notationLetterIndex => notationLetters.indexOf(letter);

  int get pieceNumber => int.parse(notationValue.substring(1));

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
  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    printWarning('Clicked $notationValue');
    int moveCount = isFirstMove ? 2 : 1;
    return calculateMoves([], notationValue, moveCount, gamePieces);
  }

  List<String> calculateMoves(
      List<String> moves, String currentTile, int moveCount, Map<String, GamePiece> gamePieces) {
    int nextRowNumber = pieceNumber + _moveCalcHelper;
    String nextTile = '$letter$nextRowNumber';

    if (moveCount == 0 || gamePieces[nextTile] != null) {
      // check and add enemies last
      getDiagonals().forEach((diagonal) {
        GamePiece? piece = gamePieces[diagonal];
        if (piece != null && piece.color != color && gamePieces[diagonal]?.name != 'KING') {
          moves.add(piece.notationValue);
        }
      });
      return moves;
    }

    moves.add(nextTile);
    return calculateMoves(moves, nextTile, moveCount - 1, gamePieces);
  }

  List<String> getDiagonals() {
    int nextRowNumber = pieceNumber + _moveCalcHelper;
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
