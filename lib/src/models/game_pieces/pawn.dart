import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'game_piece_interface.dart';

class Pawn implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;
  bool isFirstMove = true;

  late final int _moveCalcHelper = color == PieceColor.white ? 1 : -1;

  Pawn({required this.notationValue, required this.color}) {
    svg = SvgPicture.asset(
      "assets/PAWN.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move(String moveTo) {
    // TODO: implement move
    isFirstMove = false;
    notationValue = moveTo;

  }

  // dont want to re-write every game piece right now (For testing)
  void pawnMove(String to){
    isFirstMove = false;
  }

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
    int nextRow = int.parse(currentTile.substring(1)) + _moveCalcHelper;
    String letter = notationValue.substring(0, 1);
    String nextTile = '$letter$nextRow';

    if (moveCount == 0 || gamePieces[nextTile] != null) {
      return moves;
    }
    moves.add(nextTile);
    return calculateMoves(moves, nextTile, moveCount - 1, gamePieces);
  }
}
