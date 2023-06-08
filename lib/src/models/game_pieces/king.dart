import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import '../../constants.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class King implements GamePiece {
  late String name = 'KING';
  late PieceColor color;
  late String notationValue;
  late Map<String, GamePiece> _pieces;
  late List<String> availableMoves = [];
  late List<String> _enemyMoves = [];
  List<List<int>> directions = [
    [-1, 0],
    [1, 0],
    [0, 1],
    [0, -1],
    [-1, -1],
    [1, -1],
    [-1, 1],
    [1, 1]
  ];

  King({required this.notationValue, required this.color});

  King.fromJson(Map<String, dynamic> json) {
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
    notationValue = moveTo;
  }

  @override
  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    _pieces = gamePieces;
    printWarning('Clicked $notationValue');
    for (var dir in directions) {
      calculateMoves(dir, notationValue);
    }

    getAllEnemyMoves(gamePieces);
    return filterMoves(availableMoves);
  }

  void calculateMoves(List<int> dir, String currentTile) {
    if (!isNextTileOutsideBorders(currentTile, dir) ||
        (_pieces[currentTile] != null && _pieces[currentTile]?.color != color)) return;
    String nextTile =
        "${notationLetters[currentTile.index() + dir[0]]}${currentTile.number() + dir[1]}";
    if (_pieces[nextTile]?.color == color) return;

    availableMoves.add(nextTile);
  }

  bool isNextTileOutsideBorders(String currentTile, List<int> dir) {
    int letterVal = currentTile.index() + dir[0];
    int numberVal = currentTile.number() + dir[1];
    return letterVal >= 0 && letterVal < 8 && numberVal > 0 && numberVal < 9;
  }

  List<String> filterMoves(List<String> moves) {
    moves.removeWhere((value) => _enemyMoves.contains(value) && _pieces[value] == null);
    if (isUnderAttack(_pieces)) {
      moves.removeWhere((e) => !isNextMoveValid(e));
    }
    return moves;
  }

  bool isUnderAttack(Map<String, GamePiece> gamePieces) {
    getAllEnemyMoves(gamePieces);
    if (_enemyMoves.contains(notationValue)) return true;
    return false;
  }

  bool isNextMoveValid(String move) {
    Map<String, GamePiece> newGamePieces = Map.from(_pieces);
    newGamePieces[move] = King(notationValue: move, color: color);
    newGamePieces.remove(notationValue);
    King newKing = newGamePieces[move] as King;
    if (newKing.isUnderAttack(newGamePieces)) return false;
    return true;
  }

  bool isUnblockable(String move) {
    List<String> myPiecesMoves = getAllMyPiecesMoves(_pieces);
    return myPiecesMoves.contains(move);
  }

  bool isAttackDefendable(Map<String, GamePiece> gamePieces) {
    List<String> attackingEnemyMoves = getAttackingEnemyMoves(gamePieces);
    Map<String, GamePiece> myPieces = myPiecesWithoutKing(gamePieces);
    for (final piece in myPieces.values) {
      List<String> defenderMoves = piece.getAvailableMoves(gamePieces);
      for (final move in defenderMoves) {
        if (attackingEnemyMoves.contains(move)) {
          return true;
        }
      }
    }
    return false;
  }

  List<String> getAttackingEnemyMoves(gamePieces) {
    List<String> moves = [];
    Map<String, GamePiece> enemyPieces = allEnemyPieces(gamePieces);
    for (final piece in enemyPieces.values) {
      List<String> attackerMoves = piece.getAvailableMoves(gamePieces);
      if (attackerMoves.contains(notationValue)) {
        moves = filterAttackerMovesToKing(attackerMoves, piece.notationValue);
      }
    }

    return moves;
  }

  List<String> filterAttackerMovesToKing(List<String> attackerMoves, String attackerPos) {
    List<String> moves = [];
    for (String move in attackerMoves) {
      if (move == attackerPos) moves = [];
      if (move == notationValue) break;
      moves.add(move);
    }
    return moves;
  }

  // TODO: maybe can use set
  void getAllEnemyMoves(Map<String, GamePiece> gamePieces) {
    _pieces = gamePieces;
    if (_enemyMoves.isNotEmpty) return;
    Map<String, GamePiece> enemyPieces = allEnemyPieces(gamePieces);
    for (final piece in enemyPieces.values) {
      if (piece is Pawn) {
        _enemyMoves.addAll(piece.getDiagonals());
        continue;
      }
      if (piece is King) {
        _enemyMoves.addAll(calculateEnemyKingMoves(gamePieces, piece.notationValue));
        continue;
      }
      List<String> enemyMoves = piece.getAvailableMoves(gamePieces);
      for (String move in enemyMoves) {
        if (!_enemyMoves.contains(move)) {
          _enemyMoves.add(move);
        }
      }
    }
  }

  List<String> calculateEnemyKingMoves(Map<String, GamePiece> gamePieces, String currentTile) {
    List<String> enemyKingMoves = [];
    for (var dir in directions) {
      if (!isNextTileOutsideBorders(currentTile, dir)) continue;
      String nextTile =
          "${notationLetters[currentTile.index() + dir[0]]}${currentTile.number() + dir[1]}";
      if (gamePieces[nextTile] != null && gamePieces[nextTile]?.color != color) continue;

      enemyKingMoves.add(nextTile);
    }

    return enemyKingMoves;
  }

  // TODO: maybe can use set
  List<String> getAllMyPiecesMoves(Map<String, GamePiece> gamePieces) {
    Map<String, GamePiece> myPieces = myPiecesWithoutKing(gamePieces);
    List<String> myPiecesMoves = [];
    for (final piece in myPieces.values) {
      List<String> pieceMoves = piece.getAvailableMoves(gamePieces);
      for (String move in pieceMoves) {
        if (!myPiecesMoves.contains(move)) {
          myPiecesMoves.add(move);
        }
      }
    }
    return myPiecesMoves;
  }

  Map<String, GamePiece> allEnemyPieces(Map<String, GamePiece> gamePieces) {
    return Map.from(gamePieces)..removeWhere((_, value) => value.color == color);
  }

  Map<String, GamePiece> myPiecesWithoutKing(Map<String, GamePiece> gamePieces) {
    return Map.from(gamePieces)
      ..removeWhere((_, value) => value.color != color || value.name == 'KING');
  }
}
