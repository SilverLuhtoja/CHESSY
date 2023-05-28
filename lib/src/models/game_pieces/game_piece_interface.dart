import 'dart:ui';
import 'package:flutter/material.dart';

import '../../constants.dart';

enum PieceColor { white, black }

extension PieceColorFunc on PieceColor {
  Color getColor() {
    if (name == 'white') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static PieceColor fromJson(String value) {
    if (value == 'white') {
      return PieceColor.white;
    }
    return PieceColor.black;
  }
}

extension GamePieceMapMethods on Map<String, GamePiece> {
  bool isNotKing(String value) {
    return this[value]?.name != 'KING';
  }
}

extension NotationValueMethods on String {
  int number() => int.parse(substring(1));

  String letter() => substring(0, 1);

  int index() => notationLetters.indexOf(letter());
}

abstract class GamePiece {
  late PieceColor color;
  late String notationValue; // 'g5' 'a1'
  late String name;

  void move(String moveTo); // sending data
  bool canMove(); // check before move

  Map<String, dynamic> toJson();

  List<String> getAvailableMoves(Map<String, GamePiece> gamePieces) {
    // TODO: implement getAvailableMoves
    throw UnimplementedError();
  }
}
