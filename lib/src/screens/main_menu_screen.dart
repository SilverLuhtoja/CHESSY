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
                  // SizedBox(
                  //     width: 160,
                  //     child: MenuButton(
                  //         text: "Join Game",
                  //         handler: () async {
                  //           //GET AVAILABLE ROOMS FROM DB
                  //           try {
                  //             var res = await client
                  //                 .from('GAMEROOMS')
                  //                 .select('game_id')
                  //                 .is_('black_id', null);
                  //             printWarning('FROM DB ${res}');
                  //             // throw Error();
                  //               //if there are rooms available, then join
                  //               if (res.length == 0) {
                  //                 showError(
                  //                     currentContext: context,
                  //                     message: 'NO AVAILABLE ROOMS TO PLAY. CREATE SOME! ',
                  //                     isError: false);
                  //                 return;
                  //               }
                  //               int available_room = res[0]['game_id'];
                  //               printWarning('ROOM TO JOIN: $available_room');
                  //               //JOIN FIRST AVAILABLE ROOM
                  //               try {
                  //                 String? myUUID = await getUUID();
                  //                 if (myUUID == null) {
                  //                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //                     content: Text('Please restart you app '),
                  //                   ));
                  //                   return;
                  //                 }
                  //                 await Supabase.instance.client
                  //                     .from('GAMEROOMS')
                  //                     .update({'black_id': myUUID}).eq('game_id', available_room);
                  //                 if (mounted) {
                  //                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //                     content: Text('ROOM JOINED '),
                  //                   ));
                  //                   //Navigate to game screen
                  //                   navigateTo(const GameScreen());
                  //                 }
                  //               } catch (e) {
                  //                 printError('$e');
                  //                 showError(
                  //                     currentContext: context,
                  //                     message: 'Couldn`t join. Please try again ',
                  //                     isError: true);
                  //               }
                  //           } catch (e) {
                  //             printError('$e');
                  //             showError(
                  //                 currentContext: context,
                  //                 message: 'Could not connect to DB. Please try again ',
                  //                 isError: true);
                  //           }
                  //         })),
                  const SizedBox(height: 20),
                  MenuButton(text: "How to PLay?", handler: null),
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
