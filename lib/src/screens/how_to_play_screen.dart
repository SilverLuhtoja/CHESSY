import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/main_menu_widgets/buttons/button.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isVisible ? const Text("History") : const Text('Rules'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Column(
            children: [
              Visibility(
                visible: _isVisible,
                child: History(),
              ),
              Visibility(
                visible: !_isVisible,
                child: const Rules(),
              ),
              const SizedBox(height: 30),
              MenuButton(
                  text: _isVisible ? 'RULES' : 'BACK TO HISTORY',
                  handler: () => setState(() {
                        _isVisible = !_isVisible;
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  History({super.key});

  String chessHistory =
      'The game of chess is believed to have originated in India, where it was call Chaturange prior to the 6th century AD. The game became popular in India and then spread to Persia, and the Arabs. The Arabs coined the term “Shah Mat”, which translates to “the King is dead”. This is where the word “checkmate” came from.';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      Image.asset(
        'assets/chahMat.jpg',
        height: 200,
      ),
      SizedBox(height: 30),
      Text(chessHistory),
      SizedBox(height: 30),
      Image.asset(
        'assets/chess-pieces.jpg',
        height: 100,
      ),
    ]);
  }
}

class Rules extends StatefulWidget {
  const Rules({super.key});

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  String _imageName = 'assets/pawn_move.jpg';
  String _selected = 'pawn';

  var gameRules = {
    "pawn": {
      "image": "assets/pawn_move.jpg",
      'text':
          'PAWNS are unusual because they move and capture in different ways\n',
      "MOVE":
          "MOVE:\n* If first move: can move forward one or two squares.\n* All other moves: forward one square at a time\n\n ATTACK: diagonally",
      'SPECIAL': 'En Passant'
    },
    "knight": {
      "image": "assets/knight_move.jpg",
      'text': 'KNIGHTS are the only pieces that can move over other pieces.\n',
      "MOVE":
          "MOVE and ATTACK:\ngoing two squares in one direction + then one more move at a 90-degree angle.\n\n * just like the shape of an “L”",
    },
    "king": {
      "image": "assets/king_move.jpg",
      "MOVE":
          "MOVE and ATTACK:\n\n * ONE square in any direction:\n *up \n*down \n *sideways\n *diagonally",
    },
    "queen": {
      "image": "assets/queen_move.png",
      "MOVE": "MOVE and ATTACK:\n\n *up \n*down \n *sideways\n *diagonally",
    },
    "bishop": {
      "image": "assets/bishop_move.png",
      "MOVE": "MOVE and ATTACK:\n\n *only diagonally",
    },
    "rook": {
      "image": "assets/rook_move.png",
      "MOVE": "MOVE and ATTACK:\n\n *up \n*down \n *sideways",
      'SPECIAL': 'Castling'
    },
    "En Passant": {
      'text': 'PAWN Special Rule: \n\n',
      "image": "assets/en_passant.png",
      "MOVE":
          "If a pawn moves out two squares on its first move, and by doing so lands to the side of an opponent´s pawn (effectively jumping past the other pawn´s ability to capture it), that other pawn has the option of capturing the first pawn as it passes by.\nThis special move must be done immediately after the first pawn has moved past, otherwise the option to capture it is no longer available."
    },
    "Castling": {
      'text': 'ROOK Special Rule: \n\n',
      "image": "assets/en_passant.png",
      "MOVE":
          "On a player´s turn he may move his king two squares over to one side and then move the rook from that side´s corner to right next to the king on the opposite side. However, in order to castle, the following conditions must be met:\n* it must be that king`s very first move \n* it must be that rook´s very first move \n* there cannot be any pieces between the king and rook \n* to move the king may not be in check or pass through check"
    }
  };

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.7;

    return Column(children: [
      Row(
        children: [
          SizedBox(
              width: 30,
              child: Column(children: [
                SelectionButton(
                    location: 'assets/PAWN.svg',
                    handler: () => setState(() {
                          _selected = 'pawn';
                        }),
                    color: _selected == 'pawn' ? Colors.blue : Colors.grey),
                SizedBox(height: 5),
                SelectionButton(
                    location: 'assets/BISHOP.svg',
                    handler: () => setState(() {
                          _selected = 'bishop';
                        }),
                    color: _selected == 'bishop' ? Colors.blue : Colors.grey),
                SizedBox(height: 5),
                SelectionButton(
                    location: 'assets/KING.svg',
                    handler: () => setState(() {
                          _selected = 'king';
                        }),
                    color: _selected == 'king' ? Colors.blue : Colors.grey),
                SizedBox(height: 5),
                SelectionButton(
                    location: 'assets/QUEEN.svg',
                    handler: () => setState(() {
                          _selected = 'queen';
                        }),
                    color: _selected == 'queen' ? Colors.blue : Colors.grey),
                SizedBox(height: 5),
                SelectionButton(
                    location: 'assets/KNIGHT.svg',
                    handler: () => setState(() {
                          _selected = 'knight';
                        }),
                    color: _selected == 'knight' ? Colors.blue : Colors.grey),
                SizedBox(height: 5),
                SelectionButton(
                    location: 'assets/ROOK.svg',
                    handler: () => setState(() {
                          _selected = 'rook';
                        }),
                    color: _selected == 'rook' ? Colors.blue : Colors.grey),
              ])),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              width: c_width,
              child: Column(
                children: [
                  //Title
                  Text(_selected.toUpperCase(), style: const TextStyle(fontSize: 24),),
                                    const SizedBox(height: 10),
                  //Some extra info
                  gameRules[_selected]!['text'] != null
                      ? Text(gameRules[_selected]!['text'] as String)
                      : Container(),
                  //Image
                  Image.asset(
                    gameRules[_selected]!['image'] as String,
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  //Move and attack info
                  Text(gameRules[_selected]!['MOVE'] as String),
                  gameRules[_selected]!['SPECIAL'] != null
                      ? Container(
                          child: Row(
                          children: [
                            Text('SPECIAL RULE:'),
                            SizedBox(
                              width: 10.0,
                            ),
                            ElevatedButton(
                                onPressed: () => setState(() {
                                      _selected =
                                          gameRules[_selected]!['SPECIAL']
                                              as String;
                                    }),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text(
                                  gameRules[_selected]!['SPECIAL'] as String,
                                ))
                          ],
                        ))
                      : Container()
                ],
              ),
            ),
          )
        ],
      ),
    ]);
  }
}

class SelectionButton extends StatelessWidget {
  final VoidCallback? handler;
  final String location;
  final Color color;

  const SelectionButton(
      {super.key,
      required this.location,
      required this.handler,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color,
      ),
      child: IconButton(
        icon: SvgPicture.asset(location),
        iconSize: 50,
        onPressed: handler,
      ),
    );
  }
}
