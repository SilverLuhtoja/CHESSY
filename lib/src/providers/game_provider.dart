import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';

// game_piece_clicked: nil
// game_pieces: Map<String, GamePiece>
// my_color: String
// my_turn: bool
// king_on_check: bool
// message: String

class GameState {
  final String? gamePieceClicked;

  GameState({this.gamePieceClicked});

  GameState copyWith({String? pieceClicked}) {
    return GameState(gamePieceClicked: pieceClicked ?? gamePieceClicked);
  }
}

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(GameState()); // init GameState in super for StateNotifierProvider

  void setLastClickedPiece(String? piece) {
    state = GameState(gamePieceClicked: piece);
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});

class GamePiecesState {
  late GameBoard gameboard;

  GamePiecesState(this.gameboard);
}

class GamePiecesStateNotifier extends StateNotifier<GamePiecesState> {
  GamePiecesStateNotifier()
      : super(GamePiecesState(GameBoard())); // init GameState in super for StateNotifierProvider

  late StreamSubscription<dynamic> _stream;

  void setNewGamePieces(Map<String, GamePiece> pieces) {
    state.gameboard.gamePieces = pieces;
  }

  startStreamTest() {
    _stream = db.createStream().listen((event) {
      dynamic json = event[0];

      if (json['db_game_board'].toString().isEmpty) {
        printError('is null');
      } else {
        final convertedData =
            Map<String, dynamic>.from(jsonDecode(json['db_game_board']) as Map<Object?, Object?>);
        final GameBoard newBoard = GameBoard.fromJson(convertedData);
        state = GamePiecesState(newBoard);
      }
    });
  }

  closeStreamTest() {
    _stream.cancel();
  }
}

final gamePiecesStateProvider =
    StateNotifierProvider<GamePiecesStateNotifier, GamePiecesState>((ref) {
  return GamePiecesStateNotifier();
});
