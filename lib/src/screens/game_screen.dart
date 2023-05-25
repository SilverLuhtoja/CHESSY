import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import 'package:replaceAppName/src/providers/game_provider.dart';
import 'package:replaceAppName/src/services/database_service.dart';
import 'package:replaceAppName/src/utils/helpers.dart';
import 'package:replaceAppName/src/widgets/game_screen_widgets/game_over_view.dart';
import 'package:replaceAppName/src/widgets/game_screen_widgets/waiting_view.dart';
import '../constants.dart';

class GameScreen extends ConsumerWidget {
  List<String> activeTiles = [];

  GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double padding = 2.0;
    final double screenWidth = MediaQuery.of(context).size.width - (4 * padding);
    final double tileSize = (screenWidth - padding * 2) / 8;
    final double tilePositionOffset = tileSize - padding * 2;
    final List<Widget> stackedBuilds = [];

    final GamePiecesState gameBoard = ref.watch(gamePiecesStateProvider);
    final Map<String, GamePiece> gamePieces = gameBoard.gameboard.gamePieces;
    final bool isWaitingForPlayer = gameBoard.waitingPlayer;
    final bool isGameOver = gameBoard.gameOverStatus == null;
    final bool isMyTurn = gameBoard.isMyTurn;

    stackedBuilds.addAll(gameBoard.gameboard.flatGrid.map((tile) => Positioned(
        top: (tile.row - 1) * tileSize + padding * 2,
        left: tile.column * tileSize + padding * 2,
        child: Container(
            width: tilePositionOffset,
            height: tilePositionOffset,
            decoration: BoxDecoration(gradient: tileStyle(tile), color: boardColor),
            child: Stack(
              children: [
                buildGridValues(tile),
                buildGamePieces(tileSize, gamePieces, tile, ref),
                buildAvailableMoveHighlight(gameBoard, tile, ref)
              ],
            )))));

    return WillPopScope(
      onWillPop: () async {
        ref.read(gamePiecesStateProvider.notifier).closeStream();
        ref.read(gamePiecesStateProvider.notifier).resetState();
        db.deleteOrUpdateRoom(gameBoard.myColor);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(title: const Text("GameScreen")),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isWaitingForPlayer
                  ? const WaitingView()
                  : isGameOver
                      ? SizedBox(
                          width: screenWidth,
                          height: screenWidth,
                          child: Container(
                            color: isMyTurn ? Colors.greenAccent : Colors.grey,
                            child: Stack(children: stackedBuilds),
                          ))
                      : GameOverView(status: gameBoard.gameOverStatus),
            ],
          )),
    );
  }

  Center buildGridValues(Tile tile) {
    return Center(
        child: Text(
      tile.notationValue,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  Container buildGamePieces(
      double tileSize, Map<String, GamePiece> gamePieces, Tile tile, WidgetRef ref) {
    Map<String, GamePiece> gamePieces = ref.watch(gamePiecesStateProvider).gameboard.gamePieces;

    //  TODO: How This should be handled?
    Color color = gamePieces[tile.notationValue]?.color.getColor() ?? Colors.red;
    String? svgToPick = gamePieces[tile.notationValue]?.name ?? "";
    return Container(
      margin: EdgeInsets.all(tileSize * 0.05),
      width: tileSize * 0.75,
      height: tileSize * 0.75,
      child: gamePieces.containsKey(tile.notationValue)
          ? GestureDetector(
              onTap: () => pieceClickedHandler(gamePieces, tile, ref),
              child: Container(
                  child: SvgPicture.asset(
                "assets/$svgToPick.svg",
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )),
            )
          : Container(),
    );
  }

  GestureDetector buildAvailableMoveHighlight(GamePiecesState gameBoard, Tile tile, WidgetRef ref) {
    return GestureDetector(
        onTap: () async => pieceMoveHandler(gameBoard, tile, ref),
        child: Container(
          child: activeTiles.contains(tile.notationValue)
              ? Container(color: availableMoveColor)
              : Container(),
        ));
  }

  void pieceClickedHandler(Map<String, GamePiece> gamePieces, Tile tile, WidgetRef ref) {
    GamePiecesState gamePiecesState = ref.watch(gamePiecesStateProvider);
    if (!gamePiecesState.isMyTurn) return;

    // ONLY RENDERS WHEN STATE IS CHANGED
    GameState pieceClickedState = ref.watch(gameStateProvider);
    GamePiece clickedPiece = gamePieces[tile.notationValue]!;
    if (clickedPiece != null && clickedPiece.color.name == gamePiecesState.myColor) {
      if (pieceClickedState.gamePieceClicked != clickedPiece.notationValue) {
        activeTiles = clickedPiece.getAvailableMoves(gamePieces);
        ref.read(gameStateProvider.notifier).setLastClickedPiece(clickedPiece.notationValue);
      } else {
        activeTiles = [];
        // needed only for re-rendering
        ref.read(gameStateProvider.notifier).setLastClickedPiece(null);
      }
    }
  }

  void pieceMoveHandler(GamePiecesState gameBoard, Tile tile, WidgetRef ref) {
    if (!ref.watch(gamePiecesStateProvider).isMyTurn) return;

    GameState pieceClickedState = ref.watch(gameStateProvider);
    String clickedValue = pieceClickedState.gamePieceClicked ?? "";
    String? otherPlayerTurnColor =
        ref.watch(gamePiecesStateProvider).myColor == 'white' ? 'black' : 'white';

    printGreen('${pieceClickedState.gamePieceClicked} -> ${tile.notationValue}');
    if (clickedValue.isNotEmpty) {
      gameBoard.gameboard.moveGamePiece(clickedValue, tile.notationValue);
      activeTiles = [];

      db.updateGamePieces(gameBoard.gameboard, otherPlayerTurnColor);
      ref.read(gameStateProvider.notifier).setLastClickedPiece(null);
    }
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
