import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:replaceAppName/src/constants.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'game_piece_interface.dart';

class Pawn implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;
  bool isFirstMove = true;

  late final int _moveCalcHelper = color == PieceColor.white ? 1 : -1;

  String get letter => notationValue.substring(0, 1);

  Pawn({required this.notationValue, required this.color}) {
    svg = SvgPicture.asset(
      "assets/PAWN.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    // 'svg': svg,
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
    int moveCount = 1;
    if (isFirstMove) {
      moveCount = 2;
      return calculateMoves([], notationValue, moveCount, gamePieces);
    }
    return calculateMoves([], notationValue, moveCount, gamePieces);
  }

  List<String> calculateMoves(
      List<String> moves, String currentTile, int moveCount, Map<String, GamePiece> gamePieces) {
    int nextRowNumber = int.parse(currentTile.substring(1)) + _moveCalcHelper;
    String nextTile = '$letter$nextRowNumber';

    if (moveCount == 0 || gamePieces[nextTile] != null) {
      // check enemies last
      getDiagonals().forEach((diagonal) {
        GamePiece? piece = gamePieces[diagonal];
        if (piece != null && piece.color != color) {
          moves.add(piece.notationValue);
        }
      });
      return moves;
    }

    moves.add(nextTile);
    return calculateMoves(moves, nextTile, moveCount - 1, gamePieces);
  }

  List<String> getDiagonals() {
    int nextRowNumber = int.parse(notationValue.substring(1)) + _moveCalcHelper;
    int letterIndex = notationLetters.indexOf(letter);

    List<String> diagonals = [
      '${notationLetters[letterIndex - 1]}$nextRowNumber',
      '${notationLetters[letterIndex + 1]}$nextRowNumber'
    ];

    return diagonals;
  }
}
