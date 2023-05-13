import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/providers/game_provider.dart';
import 'package:replaceAppName/src/services/database_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import '../constants.dart';

class GameScreenStream extends ConsumerWidget {
  List<String> activeTiles = [];

  GameScreenStream({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double padding = 1.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double tileSize = (screenWidth - padding * 2) / 8;
    double tilePositionOffset = tileSize - padding * 2;
    List<Widget> stackItems = [];
    List<Widget> gamePieces = [];
    List<Widget> availableMoves = [];

    GameState pieceClickedState = ref.watch(gameStateProvider);
    GamePiecesState gameBoard = ref.watch(gamePiecesStateProvider);

    printWarning("RENDER");

    stackItems.addAll(gameBoard.gameboard.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: Container(
          width: tilePositionOffset,
          height: tilePositionOffset,
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

    gamePieces.addAll(gameBoard.gameboard.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: GestureDetector(
          onTap: () {
            // ONLY RENDERS WHEN STATE IS CHANGED
            Pawn? clickedPiece = gameBoard.gameboard.gamePieces[tile.notationValue] as Pawn?;
            if (clickedPiece != null) {
              if (pieceClickedState.gamePieceClicked != clickedPiece.notationValue) {
                activeTiles = clickedPiece.getAvailableMoves(gameBoard.gameboard.gamePieces);
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
            child: gameBoard.gameboard.gamePieces.containsKey(tile.notationValue)
                ? Container(
                    child: SvgPicture.asset(
                    "assets/PAWN.svg",
                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ))
                : Container(),
          ),
        ))));

    // TODO: IF CLICKED ON TILE, Make new json map and update column: db_game_board
    // TODO:  db will be updated and our client will change its state and update view
    availableMoves.addAll(gameBoard.gameboard.flatGrid.map((tile) => Positioned(
        top: tile.row * tileSize + 8,
        left: tile.column * tileSize + 8,
        child: GestureDetector(
          onTap: () async {
            printGreen('${pieceClickedState.gamePieceClicked} -> ${tile.notationValue}');
            String clickedValue = pieceClickedState.gamePieceClicked ?? "";
            if (clickedValue.isNotEmpty) {
              gameBoard.gameboard.moveGamePiece(clickedValue, tile.notationValue);
              activeTiles = [];
              try {
                db.updateGamePieces(gameBoard.gameboard);
                // ref.read(gameStateProvider.notifier).setLastClickedPiece(null);

                // await db.client.from('GAMEROOMS').upsert({"db_game_board": jsonPieces}).eq('game_id', db.id);
              } catch (e) {
                ref.read(gameStateProvider.notifier).setLastClickedPiece(null);
                printError(e.toString());
              }
            }
          },
          child: Container(
            width: tilePositionOffset,
            height: tilePositionOffset,
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
