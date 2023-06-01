import 'package:flutter/material.dart';

const supabaseUrl = 'https://lcebkhdzpqhzwulyuahl.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxjZWJraGR6cHFoend1bHl1YWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODMxMzM3MjIsImV4cCI6MTk5ODcwOTcyMn0.2SDRr407Vk-5QoXf-7h-HqDhrzFbNGWOP9HfFlf73WI';

const Color gridValues = Color.fromRGBO(155, 155, 155, 1);
const Color boardColor = Color.fromRGBO(208, 207, 198, 1.0);
const Color availableMoveColor = Color.fromRGBO(150, 239, 150, 0.7);
const List<String> notationLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

List<Map<String, dynamic>> gameRules = [
  {
    'name': 'PAWN',
    "image": "assets/pawn_move.png",
    'text': 'PAWNS are unusual because they move and capture in different ways\n',
    "actions":
        "MOVE:\n* If first move: can move forward one or two squares.\n* All other moves: forward one square at a time\n\n ATTACK: diagonally",
    'SPECIAL': {
      'name': 'EN PASSANT',
      "image": "assets/en_passant.png",
      "actions":
          "If a pawn moves out two squares on its first move, and by doing so lands to the side of an opponent´s pawn (effectively jumping past the other pawn´s ability to capture it), that other pawn has the option of capturing the first pawn as it passes by.\nThis special move must be done immediately after the first pawn has moved past, otherwise the option to capture it is no longer available."
    }
  },
  {
    'name': 'KNIGHT',
    "image": "assets/knight_move.png",
    'text': 'KNIGHTS are the only pieces that can move over other pieces.\n',
    "actions":
        "MOVE and ATTACK:\n\ngoing two squares in one direction + then one more move at a 90-degree angle.\n\n * just like the shape of an “L”",
  },
  {
    'name': 'KING',
    "image": "assets/king_move.png",
    "actions":
        "MOVE and ATTACK:\n\n* ONE square in any direction:\n*up \n*down \n*sideways\n*diagonally",
  },
  {
    'name': 'QUEEN',
    "image": "assets/queen_move.png",
    "actions": "MOVE and ATTACK:\n\n*up\n*down\n*sideways\n*diagonally",
  },
  {
    'name': "BISHOP",
    "image": "assets/bishop_move.png",
    "actions": "MOVE and ATTACK:\n\n *only diagonally",
  },
  {
    'name': "ROOK",
    "image": "assets/rook_move.png",
    "actions": "MOVE and ATTACK:\n\n*up\n*down\n*sideways",
    'SPECIAL': {
      'name': 'CASTLING',
      "image": "assets/castling.gif",
      "actions":
          "On a player´s turn he may move his king two squares over to one side and then move the rook from that side´s corner to right next to the king on the opposite side. However, in order to castle, the following conditions must be met:\n* it must be that king`s very first move \n* it must be that rook´s very first move \n* there cannot be any pieces between the king and rook \n* to move the king may not be in check or pass through check"
    }
  },
];

String chessHistory =
    'The game of chess is believed to have originated in India, where it was call Chaturange prior to the 6th century AD. The game became popular in India and then spread to Persia, and the Arabs. The Arabs coined the term “Shah Mat”, which translates to “the King is dead”. This is where the word “checkmate” came from.';
