import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/models/game_board.dart';
import 'package:replaceAppName/src/models/game_pieces/game_piece_interface.dart';
import '../constants.dart';
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
  late bool waitingPlayer;
  late GameOverStatus? gameOverStatus;
  late String? myColor;

  GamePiecesState({
    required this.gameboard,
    required this.isMyTurn,
    required this.waitingPlayer,
    required this.gameOverStatus,
    required this.myColor,
  });

  static GamePiecesState init() {
    return GamePiecesState(
        gameboard: GameBoard(),
        isMyTurn: false,
        waitingPlayer: true,
        gameOverStatus: null,
        myColor: null);
  }

  GamePiecesState copyWith({required GameBoard board, required bool turn, required String? color}) {
    return GamePiecesState(
        gameboard: board,
        isMyTurn: turn,
        waitingPlayer: true,
        gameOverStatus: null,
        myColor: color);
  }
}

class GamePiecesStateNotifier extends StateNotifier<GamePiecesState> {
  GamePiecesStateNotifier() : super(GamePiecesState.init());

  late StreamSubscription<dynamic> _stream;

  void resetState() {
    state = GamePiecesState.init();
  }

  void setMyColor(String? color) {
    printState('Setting my color to : $color');
    state.myColor = color;
  }

  void setNewGamePieces(Map<String, GamePiece> pieces) {
    state.gameboard.gamePieces = pieces;
  }

  void setWaitingPlayer(bool value) {
    state.waitingPlayer = value;
  }

  void setGameOverStatus(GameOverStatus status) {
    state.gameOverStatus = status;
  }

  startStream() {
    _stream = db.createStream().listen((event) {
      final json = Map<String, dynamic>.from(event[0] as Map<Object?, Object?>);
      checkPlayerJoinEvent(json);
      checkGameOverEvent(json);

      if (json['db_game_board'].toString().isEmpty) {
        printError('is null');
      } else {
        bool myTurn = json['current_turn'] == state.myColor ? true : false;
        Map<String, dynamic> convertedData = jsonDecode(json['db_game_board']);
        final GameBoard newBoard = GameBoard.fromJson(convertedData);

        state = GamePiecesState(
            gameboard: newBoard,
            isMyTurn: myTurn,
            waitingPlayer: state.waitingPlayer,
            gameOverStatus: state.gameOverStatus,
            myColor: state.myColor);
      }
    });
  }

  void checkPlayerJoinEvent(Map<String, dynamic> json) {
    if (json['white'] != null && json['black'] != null) setWaitingPlayer(false);
  }

  // game already started and waiting player = false, one color are null > player left
  void checkGameOverEvent(Map<String, dynamic> json) {
    if (state.waitingPlayer == true) return;
    printState("CHECKING STATUS > ${json['white'] == null || json['black'] == null}");
    if (json['winner'] != null) {
      json['winner'] == state.myColor
          ? setGameOverStatus(GameOverStatus.won)
          : setGameOverStatus(GameOverStatus.lost);
      return;
    }
    if (json['white'] == null || json['black'] == null) {
      setGameOverStatus(GameOverStatus.playerSurrender);
      return;
    }
  }

  closeStream() {
    _stream.cancel();
  }
}

final gamePiecesStateProvider =
    StateNotifierProvider<GamePiecesStateNotifier, GamePiecesState>((ref) {
  return GamePiecesStateNotifier();
});
