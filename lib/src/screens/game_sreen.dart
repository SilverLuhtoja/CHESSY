import 'package:flutter/material.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/utils/helpers.dart';

import '../constants.dart';

// Map<String, int> indexes = {
//   'a': 0,
//   'b': 1,
//   'c': 2,
//   'd': 3,
//   'f': 4,
//   'g': 5,
//   'h': 6,
//   'i': 7,
// };

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameBoard board = GameBoard();

  List<String> validMoves = [];
    List<String> activeTiles = [];

  // _showMoveOptions(TapDownDetails details, Tile tile, double tileSize) {
  //   var x = details.globalPosition.dx;
  //   var y = details.globalPosition.dy;

  //   // or user the local position method to get the offset
  //   // print(details.localPosition);
  //   // printWarning("tap down tile ${tile.notationValue} " +
  //   //     x.toString() +
  //   //     ", " +
  //   //     y.toString());

  //   printWarning(
  //       'I´m ${tile.notationValue}; VALUE: ${board.gamePieces[tile.notationValue]}');
  //   validMoves =
  //       board.gamePieces[tile.notationValue]!.canMove(board.gamePieces);
  //   validMoves.forEach((element) {
  //     String row = element[1];
  //     String column = element[0];
  //     printWarning(
  //         board.gameBoard[8 - int.parse(row)][indexes[column]!].notationValue);
  //     board.gameBoard[8 - int.parse(row)][indexes[column]!].openForMove = true;
  //     setState(() {});
  //   });
  // }

  // _onTapUp(TapUpDetails details) {
  //   var x = details.globalPosition.dx;
  //   var y = details.globalPosition.dy;
  //   // or user the local position method to get the offset
  //   // print(details.localPosition);
  //   // printWarning("tap up " + x.toString() + ", " + y.toString());
  //   validMoves.forEach((element) {
  //     board.gameBoard[8 - int.parse(element[1])][indexes[element[0]]!]
  //         .openForMove = false;
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double padding = 1.0;
    double gridRowsSize = MediaQuery.of(context).size.width;
    double tileSize = (gridRowsSize - padding * 2) / 8;
    double tileWithOffset = tileSize - padding * 2;
    List<Widget> stackItems = [];
    List<Widget> gamePieces = [];
    List<Widget> availableMoves = [];
    String lastClickedPiece = '';

    print("RENDERING");

    // make gameGrid
    stackItems.addAll(board.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: Container(
          width: tileWithOffset,
          height: tileWithOffset,
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
        ))));

     // place Game Pieces
    gamePieces.addAll(board.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: GestureDetector(
          onTap: () {
            // Pawn? clickedPiece = board.gamePieces[tile.notationValue] as Pawn?;
            // if (clickedPiece != null ){
            //   setState(() {
            //     printWarning(lastClickedPiece);
            //     if (lastClickedPiece == clickedPiece.notationValue) {
            //       activeTiles = [];
            //       return;
            //     }
            //     lastClickedPiece = clickedPiece.notationValue;
            //     activeTiles =  clickedPiece.getAvailableMoves();
            //   });
            // }
          },
          child: Container(
            margin: EdgeInsets.all(tileSize * 0.05),
            width: tileSize * 0.75,
            height: tileSize * 0.75,
            child: board.gamePieces.containsKey(tile.notationValue)
                ? Container(child: board.gamePieces[tile.notationValue]?.svg)
                : Container(),
          ),
        ))));

    // Show available moves
    availableMoves.addAll(board.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: Container(
          width: tileWithOffset,
          height: tileWithOffset,
          child: activeTiles.contains(tile.notationValue)
              ? Container(color: availableMoveColor)
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
