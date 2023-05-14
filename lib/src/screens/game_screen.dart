import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/models/game_pieces/pawn.dart';
import 'package:replaceAppName/src/providers/game_provider.dart';
import 'package:replaceAppName/src/services/database_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import '../constants.dart';

class GameScreen extends ConsumerWidget {
  List<String> activeTiles = [];

  GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double padding = 2.0;
    double screenWidth = MediaQuery.of(context).size.width - (4 * padding);
    double tileSize = (screenWidth - padding * 2) / 8;
    double tilePositionOffset = tileSize - padding * 2;
    List<Widget> stackItems = [];
    List<Widget> gamePieces = [];
    List<Widget> availableMoves = [];

    GameState pieceClickedState = ref.watch(gameStateProvider);
    GamePiecesState gameBoard = ref.watch(gamePiecesStateProvider);
    Map<String, GamePiece> pieces = gameBoard.gameboard.gamePieces;
    bool isMyTurn = gameBoard.isMyTurn;

    Color getPieceColor(Map<String, GamePiece> pieces, String notationValue) {
      return pieces[notationValue]?.color == PieceColor.white ? Colors.white : Colors.black;
    }

    stackItems.addAll(gameBoard.gameboard.flatGrid.map((tile) => Positioned(
        top: (tile.row - 1) * tileSize + padding * 2,
        left: tile.column * tileSize + padding * 2,
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
        top: (tile.row - 1) * tileSize + 4,
        left: tile.column * tileSize + 4,
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
                    colorFilter: ColorFilter.mode(
                        getPieceColor(pieces, tile.notationValue), BlendMode.srcIn),
                  ))
                : Container(),
          ),
        ))));

    availableMoves.addAll(gameBoard.gameboard.flatGrid.map((tile) => Positioned(
        top: (tile.row - 1) * tileSize + 4,
        left: tile.column * tileSize + 4,
        child: GestureDetector(
          onTap: () async {
            printGreen('${pieceClickedState.gamePieceClicked} -> ${tile.notationValue}');
            String clickedValue = pieceClickedState.gamePieceClicked ?? "";
            if (clickedValue.isNotEmpty) {
              gameBoard.gameboard.moveGamePiece(clickedValue, tile.notationValue);
              activeTiles = [];
              db.updateGamePieces(gameBoard.gameboard, ref);
              ref.read(gameStateProvider.notifier).setLastClickedPiece(null);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth,
            height: screenWidth,
            child: Container(
                color: getTurnColor(isMyTurn),
                child: Stack(children: stackItems + gamePieces + availableMoves)),
          ),
        ],
      ),
    );
  }

  ColorSwatch<int> getTurnColor(bool myTurn) => myTurn ? Colors.greenAccent : Colors.grey;

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
