import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import '../../utils/helpers.dart';
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
  List<String> canMove(Map<String, GamePiece> gamePieces) {
    // TODO: implement canMove
        printWarning('Can MOve KNIGHT');

    return [];
  }

  @override
  void move() {
    // TODO: implement move
  }
}
