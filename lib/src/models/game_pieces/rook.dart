import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'game_piece_interface.dart';

class Rook implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Rook({required this.notationValue, required this.color}) {
    svg = SvgPicture.asset(
      "assets/ROOK.svg",
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
