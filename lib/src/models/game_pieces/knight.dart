import '../../constants.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class Knight implements GamePiece {
  late String name = 'KNIGHT';
  late PieceColor color;
  late String notationValue;
  late Map<String, GamePiece> _pieces;
  late List<String> _moves = [];

  int get notationLetterIndex => notationLetters.indexOf(notationValue.letter());

  int get pieceNumber => notationValue.number();

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
    _pieces = gamePieces;
    printWarning('Clicked $notationValue');
    getVerticalTileValues();
    getHorizontalTileValues();
    return filterValidMoves(_moves);
  }

  void getVerticalTileValues() {
    if (notationLetterIndex > 0) {
      String upLeftTile = '${notationLetters[notationLetterIndex - 1]}${pieceNumber - 2}';
      String downLeftTile = '${notationLetters[notationLetterIndex - 1]}${pieceNumber + 2}';
      _moves.addAll([upLeftTile, downLeftTile]);
    }
    if (notationLetterIndex < 7) {
      String upRightTile = '${notationLetters[notationLetterIndex + 1]}${pieceNumber - 2}';
      String downRightTile = '${notationLetters[notationLetterIndex + 1]}${pieceNumber + 2}';
      _moves.addAll([upRightTile, downRightTile]);
    }
  }

  void getHorizontalTileValues() {
    if (notationLetterIndex > 1) {
      String rightDownTile = '${notationLetters[notationLetterIndex - 2]}${pieceNumber - 1}';
      String rightUpTile = '${notationLetters[notationLetterIndex - 2]}${pieceNumber + 1}';
      _moves.addAll([rightDownTile, rightUpTile]);
    }

    if (notationLetterIndex < 6) {
      String leftDownTile = '${notationLetters[notationLetterIndex + 2]}${pieceNumber - 1}';
      String leftUpTile = '${notationLetters[notationLetterIndex + 2]}${pieceNumber + 1}';
      _moves.addAll([leftDownTile, leftUpTile]);
    }
  }

  List<String> filterValidMoves(List<String> moves) {
    return moves.where((move) {
      final number = move.number();
      final pieceColor = _pieces[move]?.color;
      return (0 < number && number < 8) && pieceColor != color && _pieces.isNotKing(move);
    }).toList();
  }
}
