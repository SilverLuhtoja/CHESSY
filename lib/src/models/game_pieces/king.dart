import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class King implements GamePiece {
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  King({required this.notationValue, required this.color}) {
    svg = SvgPicture.asset(
      "assets/KING.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  List<String> canMove(Map<String, GamePiece> gamePieces) {
    // TODO: implement canMove
        printWarning('Can MOve KING');

    return [];
  }

  @override
  void move(String moveTo) {
    // TODO: implement move
  }
}
