import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// SvgPicture.asset(
// "assets/pawn.svg",
// colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
// )

abstract class GamePiece {
  late SvgPicture svg;
  late String currentTile; // 'g5' 'a1'

  void move(); // sending data
  bool canMove(); // check before move
}

class Pawn implements GamePiece{
  late SvgPicture svg;
  late String currentTile;

  Pawn(this.currentTile){
    svg = SvgPicture.asset(
      "assets/pawn.svg",
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move() {
    // TODO: implement move
  }

}