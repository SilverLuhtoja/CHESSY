import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/providers/game_provider.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import '../constants.dart';
import '../services/database_service.dart';

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

    List<Widget> dataFromDB = [
      Positioned(
        top: 500,
        child: StreamBuilder(
            stream: db.createStream(gameState.gameIdInDB!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                // case ConnectionState.done: // STREAM IS NEVER DONE
                default:
                  if (snapshot.hasData){
                    if (snapshot.data[0]['history'] != null && gameState.myColor != snapshot.data[0]['history']['action_by']) {
                      String from = snapshot.data[0]['history']['from'];
                      String to = snapshot.data[0]['history']['to'];
                      printGreen('MOVE ${snapshot.data[0]['history']['from'].toString()} TO ${snapshot.data[0]['history']['to'].toString()}');
                      board.moveGamePiece(from, to);
                      String nextTurn = gameState.myColor == 'white' ? 'black' : 'white';
                      // needed only for re-rendering
                      //TODO Need somehow to rerender the page!
                      // ref.read(gameStateProvider.notifier).setLastClickedPiece(null, gameState.myColor!, gameState.gameIdInDB!, board.gamePieces);
                     
                    }
                    return Column(children: [
                      Text(snapshot.data[0]['game_id'].toString()),
                      Text(snapshot.data[0]['white_id'].toString()),
                      Text(snapshot.data[0]['black_id'].toString()),
                      Text(snapshot.data[0]['history'].toString()),
                      Text(snapshot.data[0]['current_turn'].toString())
                    ]);}
              if (snapshot.hasError) return Text('${snapshot.error}');
              return Text("DEFAULT");
            
            }
          }),
      )
    ];

    // TODO: MAJOR REFACTORING
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
            // ONLY RENDERS WHEN STATE IS CHANGED
            Pawn? clickedPiece = board.gamePieces[tile.notationValue] as Pawn?;
            if (clickedPiece != null) {
              if (gameState.gamePieceClicked != clickedPiece.notationValue) {
                activeTiles = clickedPiece.getAvailableMoves(board.gamePieces);
                ref.read(gameStateProvider.notifier).setLastClickedPiece(
                    clickedPiece.notationValue,
                    gameState.myColor!,
                    gameState.gameIdInDB!,
                    board.gamePieces);
              } else {
                activeTiles = [];
                // needed only for re-rendering
                ref.read(gameStateProvider.notifier).setLastClickedPiece(
                    null, gameState.myColor!, gameState.gameIdInDB!, board.gamePieces);
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
            printGreen(
                '${gameState.gamePieceClicked} -> ${tile.notationValue}');
            String clickedValue = gameState.gamePieceClicked ?? "";
            if (clickedValue.isNotEmpty) {
              board.moveGamePiece(clickedValue, tile.notationValue);
              activeTiles = [];
              ref.read(gameStateProvider.notifier).setLastClickedPiece(
                  null, gameState.myColor!, gameState.gameIdInDB!, board.gamePieces);
              db.sendData(gameState.myColor!, clickedValue, tile.notationValue,
                  gameState.gameIdInDB!);
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
      body: Stack(
          children: stackItems + gamePieces + availableMoves + dataFromDB ),
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
