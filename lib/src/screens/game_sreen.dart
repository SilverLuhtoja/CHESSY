import 'package:flutter/material.dart';
import 'package:replaceAppName/src/models/game_board.dart';

import '../constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameBoard board = GameBoard();

  @override
  Widget build(BuildContext context) {
    double padding = 2.0;
    double gridRowsSize = MediaQuery.of(context).size.width;
    double tileSize = (gridRowsSize - padding * 2) / 8;
    List<Widget> stackItems = [];

    stackItems.addAll(board.gameBoard.expand((e) => e).map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: Container(
          width: tileSize - padding * 2,
          height: tileSize - padding * 2,
          decoration: BoxDecoration(gradient: tileStyle(tile), color: boardColor),
          child: Center(
              child: Text(
            tile.notationValue,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          )),
        ))));

    stackItems.addAll(board.gameBoard.expand((e) => e).map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: Container(
          margin: EdgeInsets.all(tileSize * 0.05),
          width: tileSize * 0.75,
          height: tileSize * 0.75,
          child: board.gamePieces.containsKey(tile.notationValue)
              ? Container(child: board.gamePieces[tile.notationValue]?.svg)
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
