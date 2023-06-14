import 'package:flutter/material.dart';
import 'package:replaceAppName/src/screens/pre_game_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  const PreGameScreen(),
    );
  }
}
