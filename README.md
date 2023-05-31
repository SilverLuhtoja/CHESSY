# FlutterTemplate

Basic template for Flutter apps

database password: kood01chessy <br>
KOOD01: https://github.com/01-edu/public/tree/master/subjects/mobile-dev/chess

### NEEDED CHANGES / BUGS:

* DB also need history column
* Refactor knight logic as in other piece logic, simplify pawns logic

### THOUGHTS:

* How do handle check ???
   * Every turn other player first have to check if his king is on check.
    Basically the checking will work as queen moves + checking horse and pawns around 3 squares
   * ~~Extra table to database and piece logic check if piece is threatening king,
      if it is update database table with current piece~~

* How do make the end game logic when king is on check?
    1. When player moves to block or kill the threat, then it needs to check again if king is still in check
        * if it is then this move is invalid, and it doesn't let to make this move
    2. Game over is when king cant move anymore and there is no other pieces to block or kill the threat
        1. get attacking piece array moves to king (including it notationValue)
        2. get all defending pieces available moves (meaning loop every piece)
           and see if there are values that will include in attacking piece
            * this will give all blockers and killers
        3. get all king moves
            1. if there is no available moves left for king, but can kill pieces
                * if attacking piece don't have defenders, then king can kill
                * if attacking piece has defenders  (meaning if king kills, but he will again be in check)
                  and king has no other moves
                * !!! THEN GAMEOVER !!!


* There is not much difference when creating and joining game currently, because the logic is the same.
  Join button makes sense only if app shows available rooms to join as list. So combine create and join button
  or make list of available rooms?
  This would need Also userNames to show, to easily recognize your friends game (simpler that following UUID)

* Show only INGAME and WAITING Games? Not Show at all?

## TODO <  History Of Development > :

1. Creating game:

- [x] randomize color (set this color in state ??? )
- [x] send gamepieces as map and send color with player uuid
- [x] get created room id to listen to
- [x] setup player board with database map (not init with Gameboard.gamepieces, should come through database)
- [x] Show player that it's currently his turn, after move change turn
- [x] Block player interactions when it's not currently his turn
- [x] show player that 'Waiting for player'

2. Join game: (GameStarter, kicking off)

- [x] find free room and join
- [x] setup gamepieces (again through database)
- [x] Find out what color is available, assign uuid, set his states (myColor)
- [x] playable with other player

INCLUDING:

- [x] When one of players leaves room, notify other player
- [x] When winner assigned, notify both players

NOTE : Before full gamelogic development rethink if things can be simplified, also (DRY & SOLID)

3. GameLogic:

- [x] GameBoard and pieces has set up correctly
- [ ] Board notation numbers and letters are easy to read (Like Leonards)
- [ ] Every piece is clickable
- [ ] GameLogic is understandable and flexible ( PiecesMap don't have to be in gameboard, or board holds all pieces?)

NOTFICATIONS:

- [ ] Notify player that KING is in check

PAWNS:

- [x] Pawns are able to take each other
- [x] Pawns move as expected and based on rules
- [ ] Last row on gameboard, choose -> Queen,Rook,Knight,Bishop (SPECIAL MOVE)
- [ ] Pawns can take next to each other (SPECIAL MOVE)

KNIGHTS:

- [x] show available moves and can move

BISHOPS:

- [x] show available moves and can move

ROOK:

- [x] show available moves and can move

QUEEN:

- [x] show available moves and can move

THE KING:

- [x] show available moves and can move
- [ ] When King and Rook have not moved, can make Castling (SPECIAL MOVE)
- [ ] When King is under attack, then every other gamepiece can only move to kill threat or cover its line of fire
- [ ] Nobody can kill THE KING

4. MainMenu

- [ ] Show statistics [ONLINE(players), INGAME (games), WAITING(games)]
- [ ] Listen database and disable JoinButton when there are no room available

5. HowToPlay

- [ ] code is modular and simple to change
- [ ] all info provided

6. Finishing touches

- [ ] play tested
- [ ] clean up unnecessary code (functions, files, dependencies, models, widgets)

### OTHER INFO:

    Table GAMEROOMS
    0 : { 
        white: player_UUID
        black: player_UUID
        db_game_board: Map<String,GamePiece> as String
        current_turn: player_UUID or color 
        winner: nil (player_UUID if won)
        game_state: DbGameState(INGAME, WAITING, GAMEOVER)
    }

    * GameState needs to hold:
        game_piece_clicked: nil
        game_pieces: Map<String, GamePiece>
        my_color: String
        my_turn: bool
        king_on_check: bool
        message: String

DEPENDENCIES:<br>
shared_preferences: https://pub.dev/packages/shared_preferences <br>
flutter_riverpod: https://pub.dev/packages/flutter_riverpod <br>
supabase_flutter:https://pub.dev/packages/supabase_flutter <br>

#testing <br>
mockito: https://pub.dev/packages/mockito  <br>
build_runner: https://pub.dev/packages/build_runner  <br>

#database <br>
supabase: https://supabase.com/ <br>

![img.png](img.png)
