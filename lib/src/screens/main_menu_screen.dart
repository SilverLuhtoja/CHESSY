import 'package:flutter/material.dart';
import 'package:replaceAppName/src/screens/supabase_test_screen.dart';
import 'package:replaceAppName/src/widgets/main_menu_widgets/app_statistics.dart';
import 'package:replaceAppName/src/widgets/main_menu_widgets/buttons/button.dart';
import 'package:replaceAppName/src/widgets/main_menu_widgets/buttons/join_game_button.dart';
import 'package:replaceAppName/src/widgets/uuid_container.dart';
import '../widgets/main_menu_widgets/buttons/new_game_button.dart';
import 'how_to_play_screen.dart';

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
    // db.removeAllSubriptions();
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainMenu"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10, child: Text("C H E S S Y", style: style())),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UuidContainer(),
                  const AppStatistics(),
                  const SizedBox(height: 20),
                  const NewGameButton(),
                  const SizedBox(height: 20),
                  const JoinGameButton(),
                  const SizedBox(height: 20),
                  MenuButton(text: "How to PLay?", handler: () => navigateTo(const HowToPlayScreen())),
                  const SizedBox(height: 20),
                  MenuButton(
                      text: "To Supabase Test",
                      handler: () => navigateTo(const SupabaseTestScreen()))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle style() => const TextStyle(fontSize: 60);
}
