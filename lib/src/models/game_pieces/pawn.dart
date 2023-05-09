import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import '../../utils/helpers.dart';
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
  List<String> canMove(Map<String, GamePiece> gamePieces) {
    // TODO: implement canMove

    printWarning('Can MOve PAWN');
    List<String> validMoves = [];
    // //if original position can move 2 steps ahead
    // String letter = notationValue[0];
    // int row = int.parse(notationValue[1]);
    // if (color == PieceColor.white) {
    //   if (row == 2) {
    //     // if initial row, then can move 1 AND 2 steps UP
    //     if (gamePieces['${letter}3'] == null) {
    //       validMoves.add('${letter}3');
    //     }
    //     if (gamePieces['${letter}4'] == null) {
    //       validMoves.add('${letter}4');
    //     }
    //   } else {
    //     //else can move only 1 step UP
    //     if (gamePieces['${letter}${row + 1}'] == null && row + 1 <= 8) {
    //       validMoves.add('${letter}${row + 1}');
    //     }
    //   }
    // } else if (color == PieceColor.black) {
    //   if (row == 7) {
    //     // if initial row, then can move 1 AND 2 steps DOWN
    //     if (gamePieces['${letter}6'] == null) {
    //       validMoves.add('${letter}6');
    //     }
    //     if (gamePieces['${letter}5'] == null) {
    //       validMoves.add('${letter}5');
    //     }
    //   } else {
    //     //else can move only 1 step DOWN
    //     if (gamePieces['${letter}${row - 1}'] == null && row - 1 >= 1) {
    //       validMoves.add('${letter}${row - 1}');
    //     }
    //   }
    // }
    // printGreen("CAN MOVE TO ${validMoves}");

    return validMoves;
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
