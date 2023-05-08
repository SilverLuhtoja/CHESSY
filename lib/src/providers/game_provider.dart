// game_piece_clicked: nil
// game_pieces: Map<String, GamePiece>
// my_color: String
// my_turn: bool
// king_on_check: bool
// message: String

import 'package:flutter_riverpod/flutter_riverpod.dart';


class GameState {
  final String? gamePieceClicked;

  GameState({this.gamePieceClicked});

  GameState copyWith({String? pieceClicked}){
    return GameState(
      gamePieceClicked: pieceClicked ?? gamePieceClicked
    );
  }
}

class GameStateNotifier extends StateNotifier<GameState>{
  GameStateNotifier() : super(GameState()); // init GameState in super for StateNotifierProvider

  void setLastClickedPiece(String? piece) {
    state = GameState(gamePieceClicked: piece);
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier,GameState>((ref) {
  return GameStateNotifier();
});