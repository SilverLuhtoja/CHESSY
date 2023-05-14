import 'dart:async';
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
  final GameBoard gameboard;
  final bool isMyTurn;
  late String? myColor;

  GamePiecesState({
    required this.gameboard,
    required this.isMyTurn,
    required this.myColor,
  });

  GamePiecesState copyWith({required GameBoard board, required bool turn, required String? color}) {
    return GamePiecesState(gameboard: board, isMyTurn: turn, myColor: color);
  }
}

class GamePiecesStateNotifier extends StateNotifier<GamePiecesState> {
  GamePiecesStateNotifier()
      : super(GamePiecesState(
            gameboard: GameBoard(),
            isMyTurn: false,
            myColor: null)); // init GameState in super for StateNotifierProvider

  late StreamSubscription<dynamic> _stream;

  void setMyColor(String? color) {
    printGreen('Setting my color to : $color');
    state.myColor = color;
  }

  void setNewGamePieces(Map<String, GamePiece> pieces) {
    state.gameboard.gamePieces = pieces;
  }

  startStream() {
    _stream = db.createStream().listen((event) {
      final json = Map<String, dynamic>.from(event[0] as Map<Object?, Object?>);

      if (json['db_game_board'].toString().isEmpty) {
        printError('is null');
      } else {
        bool myTurn = json['current_turn'] == state.myColor ? true : false;
        Map<String, dynamic> convertedData = jsonDecode(json['db_game_board']);
        final GameBoard newBoard = GameBoard.fromJson(convertedData);
        state = GamePiecesState(gameboard: newBoard, isMyTurn: myTurn, myColor: state.myColor);
      }
    });
  }

  closeStream() {
    _stream.cancel();
  }
}

final gamePiecesStateProvider =
    StateNotifierProvider<GamePiecesStateNotifier, GamePiecesState>((ref) {
  return GamePiecesStateNotifier();
});
