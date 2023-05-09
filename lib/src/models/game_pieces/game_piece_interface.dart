import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  void move(String moveTo); // sending data
  List<String> canMove(Map<String, GamePiece> gamePieces); // check before move
}
