# FlutterTemplate

Basic template for Flutter apps

database password: kood01chessy <br>
KOOD01: https://github.com/01-edu/public/tree/master/subjects/mobile-dev/chess

THOUGHTS:

## TODO:

1. Creating game:

- [x] randomize color (set this color in state ??? )
- [x] send gamepieces as map and send color with player uuid
- [x] get created room id to listen to
- [x] setup player board with database map (not init with Gameboard.gamepieces, should come through database)
- [x] Show player that it's currently his turn, after move change turn
- [x] Block player interactions when it's not currently his turn
- [x] show player that 'Waiting for player'

2. Join game: (GameStarter, kicking off)

- [ ] find free room and join
- [ ] setup gamepieces (again through database)
- [ ] Find out what color is available, assign uuid
- [ ] When one of players leaves room, notify other player

NOTE : Before full gamelogic development rethink if things can be simplified (DRY)
3. Basic GameLogic (starting with only Pawns):

- [ ] Every piece is clickable (last column gives error)
- [ ] GameLogic is understandable and flexible ( PiecesMap don't have to be in gameboard, or board holds all pieces?)
- [ ] Pawns are able to take each other
- [ ] Pawns move as expected and based on rules (Last row on gameboard, choose -> Queen,Rook,Knight,Bishop)

### OTHER INFO:

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
            db_game_board: Map<String,GamePiece> as String
            current_turn: player_UUID or color 
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
supabase_flutter:https://pub.dev/packages/supabase_flutter <br>
<br>
#database <br>
supabase: https://supabase.com/ <br>

![img.png](img.png)
