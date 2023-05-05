import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// SvgPicture.asset(
// "assets/pawn.svg",
// colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
// )

enum PieceColor{
  white,
  black
}

extension PieceColorValue on PieceColor{
  Color getColor(){
    if(name == 'white'){
      return Colors.white;
    }else{
      return Colors.black;
    }
  }
}

abstract class GamePiece {
  late SvgPicture svg;
  late  PieceColor color;
  late  String notationValue; // 'g5' 'a1'

  void move(); // sending data
  bool canMove(); // check before move
}

class Pawn implements GamePiece{
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Pawn({required this.notationValue, required this.color}){
    svg = SvgPicture.asset(
      "assets/PAWN.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move() {
    // TODO: implement move
  }
}

class Rook implements GamePiece{
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Rook({required this.notationValue, required this.color}){
    svg = SvgPicture.asset(
      "assets/ROOK.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move() {
    // TODO: implement move
  }
}

class Knight implements GamePiece{
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Knight({required this.notationValue, required this.color}){
    svg = SvgPicture.asset(
      "assets/KNIGHT.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move() {
    // TODO: implement move
  }
}

class Bishop implements GamePiece{
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Bishop({required this.notationValue, required this.color}){
    svg = SvgPicture.asset(
      "assets/BISHOP.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move() {
    // TODO: implement move
  }
}


class Queen implements GamePiece{
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  Queen({required this.notationValue, required this.color}){
    svg = SvgPicture.asset(
      "assets/QUEEN.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move() {
    // TODO: implement move
  }
}


class King implements GamePiece{
  late SvgPicture svg;
  late PieceColor color;
  late String notationValue;

  King({required this.notationValue, required this.color}){
    svg = SvgPicture.asset(
      "assets/KING.svg",
      colorFilter: ColorFilter.mode(color.getColor(), BlendMode.srcIn),
    );
  }

  @override
  bool canMove() {
    // TODO: implement canMove
    throw UnimplementedError();
  }

  @override
  void move() {
    // TODO: implement move
  }
}