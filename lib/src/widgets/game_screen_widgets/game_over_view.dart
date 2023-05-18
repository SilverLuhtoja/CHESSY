import 'package:flutter/material.dart';
import '../../constants.dart';

class GameOverView extends StatefulWidget {
  final GameOverStatus? status;

  const GameOverView({super.key, required this.status});

  @override
  State<GameOverView> createState() => _GameOverViewState();
}

class _GameOverViewState extends State<GameOverView> {
  String message = "";

  @override
  void initState() {
    super.initState();
    switch (widget.status) {
      case GameOverStatus.won:
        setState(() => message = 'You have won!');
        break;
      case GameOverStatus.lost:
        setState(() => message = 'You have lost!');
        break;
      default:
        setState(() => message = 'Player has surrendered!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text("Game Over", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text(message, style: const TextStyle(fontSize: 20))
      ],
    ));
  }
}
