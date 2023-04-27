import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:replaceAppName/src/screens/game_sreen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  navigateTo(StatefulWidget screen) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainMenu"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 10, child: Text("C H E S S Y", style: style())),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                overView(),
                const SizedBox(height: 40),
                SizedBox(
                    width: 160,
                    child: buildFilledButton(
                        "New Game", () => navigateTo(const GameScreen()))),
                const SizedBox(height: 20),
                SizedBox(
                    width: 160, child: buildFilledButton("Join Game", null)),
                const SizedBox(height: 20),
                SizedBox(
                    width: 160, child: buildFilledButton("How to PLay?", null)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FilledButton buildFilledButton(String text, VoidCallback? handler) =>
      FilledButton(onPressed: handler, child: Text(text));

  TextStyle style() => const TextStyle(fontSize: 60);

  Widget overView() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        singleOveview(Icons.people, "ONLINE", 7),
        const SizedBox(width: 20),
        singleOveview(Icons.play_circle, "IN GAME", 4),
        const SizedBox(width: 20),
        singleOveview(Icons.timelapse, "WAITING", 3),
      ]);

  Column singleOveview(IconData icon, String text, int value) {
    return Column(children: [Icon(icon), Text(text), Text(value.toString())]);
  }
}
