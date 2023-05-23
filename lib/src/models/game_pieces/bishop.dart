import 'game_piece_interface.dart';

class Bishop implements GamePiece {
  late String name = 'BISHOP';
  late PieceColor color;
  late String notationValue;

  Bishop({required this.notationValue, required this.color});

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move(String moveTo) {
    // TODO: implement move
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    // TODO: implement getAvailableMoves
    throw UnimplementedError();
  }
}
