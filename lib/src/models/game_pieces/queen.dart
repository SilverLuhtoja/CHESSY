import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class Queen implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Queen({required this.notationValue, required this.color}) {
    svg = SvgPicture.asset(
      "assets/QUEEN.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  List<String> canMove(Map<String, GamePiece> gamePieces) {
    // TODO: implement canMove
        printWarning('Can MOve Queen');

    return [];
  }

  @override
  void move() {
    // TODO: implement move
  }
}
