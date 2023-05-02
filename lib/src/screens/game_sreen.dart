import 'dart:math';

import 'package:flutter/material.dart';
import 'package:replaceAppName/src/models/game_board.dart';

import '../constants.dart';
import '../utils/helpers.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameBoard board = GameBoard();
  Map<String, int> indexes = {
    'a': 0,
    'b': 1,
    'c': 2,
    'd': 3,
    'e': 4,
    'f': 5,
    'g': 6,
    'h': 7,
  };
  List<String> validMoves = [];

  _showMoveOptions(TapDownDetails details, Tile tile, double tileSize) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;

    // or user the local position method to get the offset
    // print(details.localPosition);
    // printWarning("tap down tile ${tile.notationValue} " +
    //     x.toString() +
    //     ", " +
    //     y.toString());

    if (tile.occupied == true) {
      printWarning(
          'MY POSITION IS ${tile.notationValue}; I am ${tile.occupancyValue}');
      validMoves = tile.occupancyValue!.canMove(board.gamePieces);
      validMoves.forEach((element) {
        String row = element[1];
        String column = element[0];
        printWarning(board
            .gameBoard[8 - int.parse(row)][indexes[column]!].notationValue);
        board.gameBoard[8 - int.parse(row)][indexes[column]!].openForMove =
            true;
        setState(() {});
      });
    }
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    // print(details.localPosition);
    // printWarning("tap up " + x.toString() + ", " + y.toString());
    validMoves.forEach((element) {
      board.gameBoard[8 - int.parse(element[1])][indexes[element[0]]!]
          .openForMove = false;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    double padding = 2.0;
    double gridRowsSize = MediaQuery.of(context).size.width;
    double tileSize = (gridRowsSize - padding * 2) / 8;
    List<Widget> stackItems = [];

    stackItems.addAll(board.gameBoard.expand((e) => e).map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: GestureDetector(
          onTap: () {},
          onTapDown: (TapDownDetails details) =>
              _showMoveOptions(details, tile, tileSize),
          onTapUp: (TapUpDetails details) => _onTapUp(details),
          child: Container(
            width: tileSize - padding * 2,
            height: tileSize - padding * 2,
            decoration:
                BoxDecoration(gradient: tileStyle(tile), color: boardColor),
            child: Center(
                child: Text(
              tile.notationValue,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ))));

    stackItems.addAll(board.gameBoard.expand((e) => e).map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: GestureDetector(
          onTap: () {},
          onPanUpdate: (DragUpdateDetails details) {
            // see https://www.youtube.com/watch?v=WhVXkCFPmK4
            // _top = max(0, _top + details.delta.dy);
            // _left = max(0, _left + details.delta.dx);
            // setState(() {});
          },
          onTapDown: (TapDownDetails details) =>
              _showMoveOptions(details, tile, tileSize),
          onTapUp: (TapUpDetails details) => _onTapUp(details),
          child: Container(
            margin: EdgeInsets.all(tileSize * 0.05),
            width: tileSize * 0.75,
            height: tileSize * 0.75,
            child: board.gamePieces.containsKey(tile.notationValue)
                ? Container(child: board.gamePieces[tile.notationValue]?.svg)
                : Container(),
          ),
        ))));

    stackItems.addAll(board.gameBoard.expand((e) => e).map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: Container(
          margin: EdgeInsets.all(tileSize * 0.05),
          width: tileSize * 0.75,
          height: tileSize * 0.75,
          child: tile.openForMove
              ? Container(
                  child: Text('A',
                      style: TextStyle(
                        color: Colors.red,
                      )))
              : Container(),
        ))));

    return Scaffold(
      appBar: AppBar(
        title: const Text("GameScreen"),
      ),
      body: Stack(children: stackItems),
    );
  }

  LinearGradient? tileStyle(Tile tile) {
    return tile.isWhite
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(-0.8, -0.8),
            stops: [0.0, 0.4],
            colors: [
              Colors.black12,
              boardColor,
            ],
            tileMode: TileMode.repeated)
        : null;
  }
}
