import 'dart:ui';

import 'package:flutter/material.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(width: 10, child: Text("C H E S S Y", style: style())),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                overView(),
                SizedBox(height: 40),
                Container(
                    width: 160, child: buildFilledButton("New Game", () {})),
                SizedBox(height: 20),
                Container(
                    width: 160, child: buildFilledButton("Join Game", null)),
                SizedBox(height: 20),
                Container(
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

  Widget overView() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        singleOveview(Icons.people, "ONLINE", 7),
        SizedBox(width: 20,),
        singleOveview(Icons.play_circle, "IN GAME", 4),
        SizedBox(width: 20,),
        singleOveview(Icons.timelapse, "WAITING", 3),
      ]);

  Column singleOveview(IconData icon, String text, int value) {
    return Column(children: [
        Icon(icon),
        Text(text),
        Text(value.toString())
      ]);
  }
}
