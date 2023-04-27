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

    stackItems.addAll(board.gameBoard.expand((e) => e).map((e) => Positioned(
        top: e.row * tileSize + 8,
        left: e.column * tileSize + 8,
        child: Container(
          width: tileSize - padding * 2,
          height: tileSize - padding * 2,
          color: e.isWhite ? Colors.white : Colors.black26,
          child: Center(
              child: Text(
            "${(board.gameBoard.length + 1 - e.row)}${e.alphaValue}",
            style:  const TextStyle(fontSize: 20,color: gridValues,fontWeight: FontWeight.bold,),
          )),
        ))));

    return Scaffold(
      appBar: AppBar(
        title: const Text("GameScreen"),
      ),
      body: Stack(children: stackItems),
    );
  }
}
