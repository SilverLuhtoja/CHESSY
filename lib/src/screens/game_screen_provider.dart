import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/providers/game_provider.dart';
import 'package:replaceAppName/src/utils/helpers.dart';

import '../constants.dart';

class GameScreenTest extends ConsumerWidget {
  GameScreenTest({Key? key}) : super(key: key);

  GameBoard board = GameBoard();
  List<String> activeTiles = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double padding = 1.0;
    double gridRowsSize = MediaQuery.of(context).size.width;
    double tileSize = (gridRowsSize - padding * 2) / 8;
    double tileWithOffset = tileSize - padding * 2;
    List<Widget> stackItems = [];
    List<Widget> gamePieces = [];
    List<Widget> availableMoves = [];
    GameState gameState = ref.watch(gameStateProvider);

    printWarning("RENDERING");

    // make gameGrid
    stackItems.addAll(board.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: Container(
          width: tileWithOffset,
          height: tileWithOffset,
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

    // place Game Pieces
    gamePieces.addAll(board.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: GestureDetector(
          onTap: () {
            // ONLY RENDERS WHEN STATE IS CHANGED
            Pawn? clickedPiece = board.gamePieces[tile.notationValue] as Pawn?;
            if (clickedPiece != null) {
              if (gameState.gamePieceClicked != clickedPiece.notationValue) {
                activeTiles = clickedPiece.getAvailableMoves(board.gamePieces);
                ref
                    .read(gameStateProvider.notifier)
                    .setLastClickedPiece(clickedPiece.notationValue);
              } else {
                activeTiles = [];
                // needed only for re-rendering
                ref.read(gameStateProvider.notifier).setLastClickedPiece(null);
              }
            }
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
        child: GestureDetector(
          onTap: () {
            printGreen('${gameState.gamePieceClicked} -> ${tile.notationValue}');
            String clickedValue = gameState.gamePieceClicked ?? "";
            if (clickedValue.isNotEmpty) {
              board.moveGamePiece(clickedValue, tile.notationValue);
              activeTiles = [];
              ref.read(gameStateProvider.notifier).setLastClickedPiece(null);
            }
          },
          child: Container(
            width: tileWithOffset,
            height: tileWithOffset,
            child: activeTiles.contains(tile.notationValue)
                ? Container(color: availableMoveColor)
                : Container(),
          ),
        ))));

    return Scaffold(
      appBar: AppBar(
        title: const Text("GameScreen"),
      ),
      body: Stack(children: stackItems + gamePieces + availableMoves),
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
