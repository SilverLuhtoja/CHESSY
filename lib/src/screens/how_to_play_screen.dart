import 'package:flutter/material.dart';

import '../widgets/main_menu_widgets/buttons/button.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  String rules = 'PAWNS are unusual because they move and capture in different ways: they move forward but capture diagonally.' +
                            'Pawns can only move forward one square at a time, except for their very first move where they can move forward two squares.\n\n' +
                            'Pawns have another special ability and that is that if a pawn reaches the other side of the board it can become any other chess piece' +
                            '(called promotion) excluding a king.' +
                            'A common misconception is that pawns may only be exchanged for a piece that has been captured. That is NOT true. A pawn is usually promoted to a queen. Only pawns may be promoted.';
  String imageName = 'assets/pawn_move.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How To Play?"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Row(children: [
                  SelectionButton(
                    text: 'PAWN',
                    handler: () => setState(
                      () {
                        rules = 'PAWNS are unusual because they move and capture in different ways: they move forward but capture diagonally.' +
                            'Pawns can only move forward one square at a time, except for their very first move where they can move forward two squares.\n\n' +
                            'Pawns have another special ability and that is that if a pawn reaches the other side of the board it can become any other chess piece' +
                            '(called promotion) excluding a king.' +
                            'A common misconception is that pawns may only be exchanged for a piece that has been captured. That is NOT true. A pawn is usually promoted to a queen. Only pawns may be promoted.';
                        imageName = 'assets/pawn_move.jpg';
                      },
                    ),
                    special: false,
                  ),
                  const SizedBox(width: 5),
                  SelectionButton(
                    text: 'KING',
                    handler: () => setState(
                      () {
                        rules =
                            'The KING can only move ONE square in any direction - up, down, to the sides, and diagonally.';
                        imageName = 'assets/king_move.jpg';
                      },
                    ),
                    special: false,
                  ),
                  const SizedBox(width: 5),
                  SelectionButton(
                    text: 'QUEEN',
                    handler: () => setState(
                      () {
                        rules =
                            'The QUEEN can move in any one straight direction - forward, backward, sideways, or diagonally - as far as possible as long as she does not move through any of her own pieces.';
                        imageName = 'assets/queen_move.png';
                      },
                    ),
                    special: false,
                  ),
                  const SizedBox(width: 5),
                  SelectionButton(
                    text: 'En Passant',
                    handler: () => setState(
                      () {
                        rules =
                            'If a pawn moves out two squares on its first move, and by doing so lands to the side of an opponent´s pawn (effectively jumping past the other pawn´s ability to capture it), that other pawn has the option of capturing the first pawn as it passes by.\nThis special move must be done immediately after the first pawn has moved past, otherwise the option to capture it is no longer available.';
                        imageName = 'assets/en_passant.png';
                      },
                    ),
                    special: true,
                  ),
                ]),
              ),
              Row(children: [
                SelectionButton(
                  text: 'BISHOP',
                  handler: () => setState(
                    () {
                      rules =
                          'The BISHOP may move as far as it wants, but only diagonally. Each bishop starts on one color (light or dark) and must always stay on that color.';
                      imageName = 'assets/bishop_move.png';
                    },
                  ),
                  special: false,
                ),
                const SizedBox(width: 5),
                SelectionButton(
                  text: 'KNIGHT',
                  handler: () => setState(
                    () {
                      rules =
                          'The KNIGHT move in a very different way from the other pieces – going two squares in one direction, and then one more move at a 90-degree angle, just like the shape of an “L”. \nKnights are also the only pieces that can move over other pieces.';
                      imageName = 'assets/knight_move.jpg';
                    },
                  ),
                  special: false,
                ),
                const SizedBox(width: 5),
                SelectionButton(
                  text: 'ROOK',
                  handler: () => setState(
                    () {
                      rules =
                          'The ROOK may move as far as it wants, but only forward, backward, and to the sides.';
                      imageName = 'assets/rook_move.png';
                    },
                  ),
                  special: false,
                ),
                const SizedBox(width: 5),
                SelectionButton(
                  text: 'CASTLING',
                  handler: () => setState(
                    () {
                      rules =
                          'Special rule called castling. This move allows you to do two important things all in one move: get your king'
                          +' to safety (hopefully), and get your rook out of the corner and into the game.\nOn a player´s turn he may move '
                          + 'his king two squares over to one side and then move the rook from that side´s corner to right next to the king on'
                          +' the opposite side. However, in order to castle, the following conditions must be met:'
                          +'\n* it must be that king`s very first move \n* it must be that rook´s very first move \n* there cannot be any pieces between '
                          + 'the king and rook \n* to move the king may not be in check or pass through check';
                      imageName = 'assets/castling.gif';
                    },
                  ),
                  special: true,
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                imageName,
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: true,
                maintainSize: true, //NEW
                maintainAnimation: true, //NEW
                maintainState: true, //NEW
                child: Text(rules),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  final VoidCallback? handler;
  final String text;
  final bool special;

  const SelectionButton({super.key, required this.text, required this.handler, required this.special});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 85, child: FilledButton(onPressed: handler, child: Text(text, style: TextStyle(  fontStyle: special? FontStyle.italic : FontStyle.normal))),);
  }
}
