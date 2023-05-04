# FlutterTemplate
Basic template for Flutter apps

database password: kood01chessy <br>
KOOD01: https://github.com/01-edu/public/tree/master/subjects/mobile-dev/chess

### TODO:
1. When player click on 'New Game'
    * Gamelogic will set up:
      * gameboard with gamepieces
      * assigns player gamepieces color to player randomly (black || white)
        * Shows player his color (Name colored with his pieces color for example)
        * Shows 'Waiting for player' (opens dialog box for example)
    * Supabase service will set up info in database
      * INSERT's to table 'GAMEROOMS' new room with int value
      ````
      Table GAMEROOMS
        0 : { 
            white: player_UUID
            black: player_UUID
            history: Map<String,GamePiece>
            current_turn: player_UUID
            game_over: nil (player_UUID if won)
      }
      ````
    * GameState needs to hold:
      ````
        game_piece_clicked: nil
        game_pieces: Map<String, GamePiece>
        my_color: String
        my_turn: bool
        king_on_check: bool
        message: String
      ````
      

DEPENDENCIES:<br>
shared_preferences: https://pub.dev/packages/shared_preferences <br>
flutter_riverpod: https://pub.dev/packages/flutter_riverpod <br>
