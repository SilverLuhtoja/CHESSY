import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
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
  List<String> canMove(Map<String, GamePiece> gamePieces) {
    // TODO: implement canMove
    printWarning('Can MOve Rook');

    return [];
    
  }

  @override
  void move(String moveTo) {
    // TODO: implement move
  }
}
