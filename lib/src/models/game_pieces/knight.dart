import 'game_piece_interface.dart';

class Knight implements GamePiece {
  late String name = 'KNIGHT';
  late PieceColor color;
  late String notationValue;

  Knight({required this.notationValue, required this.color});

  Knight.fromJson(Map<String, dynamic> json) {
    color = PieceColorFunc.fromJson(json['color']);
    notationValue = json['notationValue'];
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color.name,
        'notationValue': notationValue,
      };

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
  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    // TODO: implement getAvailableMoves
    throw UnimplementedError();
  }
}
