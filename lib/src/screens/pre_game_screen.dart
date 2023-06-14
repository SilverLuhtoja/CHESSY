import 'package:flutter/material.dart';
import 'package:replaceAppName/src/screens/main_menu_screen.dart';

import '../services/username_service.dart';
import '../utils/helpers.dart';
import '../widgets/username_container.dart';

class PreGameScreen extends StatefulWidget {
  const PreGameScreen({super.key});

  @override
  State<PreGameScreen> createState() => _PreGameScreenState();
}

class _PreGameScreenState extends State<PreGameScreen> {
  navigateTo(StatefulWidget screen) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );

  _getName() async {
    return await getUsername();
  }

  @override
  Widget build(BuildContext context) {
    printGreen('PRE GAME SCREEN');
    return FutureBuilder(
        future: _getName(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
             printWarning('snapshot.hasData');
            printGreen('a ${snapshot.data}, ${snapshot.data.length}');
            if (snapshot.data.length == 0) {
              printWarning('snapshot.data.length == 0');
              return Scaffold(
                  appBar: AppBar(
                    title: const Text("Please add your username"),
                  ),
                  body: Center(
                      child: SingleChildScrollView(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [UsernameContainer(realoadNeeded: (value) => setState(() {
                              }),)]))));
            } else {
               printWarning('else');
              return MainMenuScreen();
            }
          } else {
            return Text('loading...');
          }
        });
  }

  TextStyle style() => const TextStyle(fontSize: 60);
}

class _getName {}
