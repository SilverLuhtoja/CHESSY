import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:replaceAppName/src/utils/helpers.dart';

// SvgPicture.asset(
// "assets/pawn.svg",
// colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
// )

enum PieceColor { white, black }

extension PieceColorValue on PieceColor {
  Color getColor() {
    if (name == 'white') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}

abstract class GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue; // 'g5' 'a1'

  void move(); // sending data
  List<String> canMove(Map<String, GamePiece> gamePieces); // check before move
}

class Pawn implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Pawn({
    required this.notationValue,
    required this.color,
  }) {
    svg = SvgPicture.asset(
      "assets/pawn.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  List<String> canMove(Map<String, GamePiece> gamePieces) {
    List<String> validMoves = [];
    // TODO: implement canMove

    //if original position can move 2 steps ahead
      String letter = notationValue[0];
      int row = int.parse(notationValue[1]);
    if (color == PieceColor.white) {

      if (row == 2) {
        // if initial row, then can move 1 AND 2 steps UP
        if (gamePieces['${letter}3'] == null) {
          validMoves.add('${letter}3');
        }
        if (gamePieces['${letter}4'] == null) {
          validMoves.add('${letter}4');
        }
      } else {
        //else can move only 1 step UP
        if (gamePieces['${letter}${row + 1}'] == null && row + 1 <= 8) {
          validMoves.add('${letter}${row + 1}');
        }
      }
    } else if (color == PieceColor.black) {
      if (row == 7) {
        // if initial row, then can move 1 AND 2 steps DOWN
         if (gamePieces['${letter}6'] == null) {
          validMoves.add('${letter}6');
        }
        if (gamePieces['${letter}5'] == null) {
          validMoves.add('${letter}5');
        }
      } else {
        //else can move only 1 step DOWN
        if (gamePieces['${letter}${row - 1}'] == null && row - 1 >= 1) {
          validMoves.add('${letter}${row - 1}');
        }
      }
    }
    printGreen("ADDED NEW MOVES ${validMoves}");
    return validMoves;
  }

  @override
  void move() {
    // TODO: implement move
  }
}
