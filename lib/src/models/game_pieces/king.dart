import 'dart:math';

import '../../constants.dart';
import '../../utils/helpers.dart';
import 'game_piece_interface.dart';

class King implements GamePiece {
  late String name = 'KING';
  late PieceColor color;
  late String notationValue;
  late Map<String, GamePiece> _pieces;
  late List<String> _moves = [];
  late List<String> _enemyMoves = [];

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
    for (var dir in directions) {
      calculateMoves(dir, notationValue);
    }

    getAllEnemyMoves(gamePieces);
    return filterMoves(_moves);
  }

  void calculateMoves(List<int> dir, String currentTile) {
    if (!isNextTileOutsideBorders(currentTile, dir) ||
        (_pieces[currentTile] != null && _pieces[currentTile]?.color != color)) return;
    String nextTile =
        "${notationLetters[currentTile.index() + dir[0]]}${currentTile.number() + dir[1]}";
    if (_pieces[nextTile]?.color == color) return;

    _moves.add(nextTile);
  }

  bool isNextTileOutsideBorders(String currentTile, List<int> dir) {
    int letterVal = currentTile.index() + dir[0];
    int numberVal = currentTile.number() + dir[1];
    return letterVal >= 0 && letterVal < 8 && numberVal > 0 && numberVal < 9;
  }

  bool isUnderAttack(Map<String, GamePiece> gamePieces) {
    getAllEnemyMoves(gamePieces);
    if (_enemyMoves.contains(notationValue)) return true;
    return false;
  }

  List<String> filterMoves(List<String> moves) {
    moves.removeWhere((value) => _enemyMoves.contains(value));
    return moves;
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
    Map<String, GamePiece> enemyPieces = enemyPiecesWithoutKing(gamePieces);
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

  void getAllEnemyMoves(Map<String, GamePiece> gamePieces) {
    if (_enemyMoves.isNotEmpty) return;
    Map<String, GamePiece> enemyPieces = enemyPiecesWithoutKing(gamePieces);
    for (final piece in enemyPieces.values) {
      List<String> enemyMoves = piece.getAvailableMoves(gamePieces);
      for (String move in enemyMoves) {
        if (!_enemyMoves.contains(move)) {
          _enemyMoves.add(move);
        }
      }
    }
  }

  Map<String, GamePiece> enemyPiecesWithoutKing(Map<String, GamePiece> gamePieces) {
    Map<String, GamePiece> newGamePieces = Map.from(gamePieces)
      ..removeWhere((key, value) => value.color == color || value.name == 'KING');
    // maybe only for testing needed ???
    // if (!gamePieces.containsKey(notationValue)) {
    //   gamePieces[notationValue] = King(notationValue: notationValue, color: color);
    // }
    return newGamePieces;
  }

  Map<String, GamePiece> myPiecesWithoutKing(Map<String, GamePiece> gamePieces) {
    Map<String, GamePiece> newGamePieces = Map.from(gamePieces)
      ..removeWhere((key, value) => value.color != color || value.name == 'KING');
    return newGamePieces;
  }
}
