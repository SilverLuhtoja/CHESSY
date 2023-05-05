import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'game_piece_interface.dart';

class Pawn implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

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
  void move() {
    // TODO: implement move
  }
}
