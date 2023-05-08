import 'package:flutter/material.dart';
import 'package:replaceAppName/src/screens/game_sreen.dart';
import 'package:replaceAppName/src/screens/supabase_test_screen.dart';
import 'package:replaceAppName/src/widgets/main_menu_widgets/app_statistics.dart';
import 'package:replaceAppName/src/widgets/main_menu_widgets/buttons/button.dart';
import 'package:replaceAppName/src/widgets/uuid_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../main.dart';
import '../services/uuid_service.dart';
import '../utils/helpers.dart';
import '../widgets/main_menu_widgets/buttons/join_game_button.dart';
import '../widgets/show_snackbar.dart';
import '../widgets/main_menu_widgets/buttons/new_game_button.dart';

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
                  const SizedBox(height: 40),
                  const NewGameButton(),
                  const SizedBox(height: 20),
                  const JoinGameButton(),
                  const SizedBox(height: 20),
                  const MenuButton(text: "How to PLay?", handler: null),
                  const SizedBox(height: 20),
                  MenuButton(
                      text: "To Supabase Test", handler: () => navigateTo(SupabaseTestScreen()))
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
