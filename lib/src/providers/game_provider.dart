import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/utils/helpers.dart';

import '../models/game_pieces/game_piece_interface.dart';

// game_piece_clicked: nil
// game_pieces: Map<String, GamePiece>
// my_color: String
// my_turn: bool
// king_on_check: bool
// message: String

class GameState {
  final String? gamePieceClicked;
   final String? currentTurn;
   final int? gameIdInDB;
   final String? myColor;
   final Map<String, GamePiece>? gamePieces;

  GameState(
      {this.gamePieceClicked, this.currentTurn, this.gameIdInDB, this.myColor, this.gamePieces});

  GameState copyWith(
      {String? pieceClicked,
      String? currentTurn,
      int? gameIdInDB,
      String? myColor,
      Map<String, GamePiece>? gamePieces}) {
    return GameState(
        gamePieceClicked: pieceClicked ?? gamePieceClicked,
        currentTurn: currentTurn ?? currentTurn,
        gameIdInDB: gameIdInDB ?? gameIdInDB,
        myColor: myColor ?? myColor,
        gamePieces: gamePieces ?? gamePieces);
  }

}

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier(): super(GameState());
  
  void setLastClickedPiece(String? piece, String myColor, int roomId,  Map<String, GamePiece>? gamePieces) {
    String nextTurn = myColor == 'white' ? 'black' : 'white';
    state = GameState(gamePieceClicked: piece, currentTurn: nextTurn, gameIdInDB:roomId, myColor: myColor, gamePieces: gamePieces );
  }
  
  void setState(int roomId, String myColor, ) {
    state = GameState(currentTurn: 'white', gameIdInDB: roomId, myColor: myColor );
  }
}

final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});
