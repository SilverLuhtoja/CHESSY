import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:replaceAppName/src/client_server.dart/client.dart';
import 'package:replaceAppName/src/screens/game_sreen.dart';

import '../utils/helpers.dart';

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
                const SizedBox(height: 20),
                SizedBox(
                    width: 160, child: buildFilledButton("SendSomething", (){
                      client.sendMessage("AND PUSHING BUTTONS");
                })),
                const SizedBox(height: 20),
                // SizedBox(
                //     width: 160, child: buildFilledButton("ConnectToServer", () async {
                //   final socket = await Socket.connect('10.0.2.2', 4000);
                //
                //   print(
                //       "Client: Connected to ${socket.remoteAddress.address}:${socket.remotePort}");
                //
                //   socket.listen((Uint8List data) {
                //     final serverResponse = String.fromCharCodes(data);
                //     printGreen(serverResponse);
                //   }, onError: (error) {
                //     printError("Client :$error");
                //     socket.destroy();
                //   }, onDone: () {
                //     printError("Client: Server left");
                //     socket.destroy();
                //   });
                //
                //
                //   socket.write("Silver");
                // })),

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
