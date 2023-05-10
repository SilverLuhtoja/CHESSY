import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'game_piece_interface.dart';

class Knight implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Knight({required this.notationValue, required this.color}) {
    svg = SvgPicture.asset(
      "assets/KNIGHT.svg",
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
  }
}
