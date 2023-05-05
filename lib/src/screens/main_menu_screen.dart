import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:replaceAppName/src/screens/game_sreen.dart';
import 'package:replaceAppName/src/screens/supabase_test_screen.dart';
import 'package:replaceAppName/src/widgets/uuid_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/uuid_service.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10, child: Text("C H E S S Y", style: style())),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UuidContainer(),
                  overView(),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 160,
                    child: buildFilledButton("New Game", () async {
                      //First send NEW ROOM info to DB
                      try {
                        String? myUUID = await getUUID();
                        if (myUUID == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please restart you app '),
                          ));
                          return;
                        }
                        await Supabase.instance.client
                            .from('GAMEROOMS')
                            .upsert({
                          'white': myUUID,
                        });
                        if (mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('ROOM CREATED '),
                          ));
                          //Navigate to game screen
                          navigateTo(const GameScreen());
                        }
                      } catch (e) {
                        printError('$e');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Error saving. Please try again '),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 160,
                      child: buildFilledButton("Join Game", () async {
                        //GET AVAILABLE ROOMS FROM DB
                        try {
                          var res = await Supabase.instance.client
                              .from('GAMEROOMS')
                              .select('game_id');
                          if (mounted) {
                            //if there are rooms available, then join
                            if (res[0]['game_id'] != null) {
                              int available_room = res[0]['game_id'];
                              printWarning('ROOM TO JOIN: $available_room');
                              //JOIN FIRST AVAILABLE ROOM
                              try {
                                String? myUUID = await getUUID();
                                if (myUUID == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Please restart you app '),
                                  ));
                                  return;
                                }
                                await Supabase.instance.client
                                    .from('GAMEROOMS')
                                    .update({'black_id': myUUID}).eq(
                                        'game_id', available_room);
                                if (mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('ROOM JOINED '),
                                  ));
                                  //Navigate to game screen
                                  navigateTo(const GameScreen());
                                }
                              } catch (e) {
                                printError('$e');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Couldn`t join. Please try again '),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('NO AVAILABLE ROOMS TO PLAY '),
                              ));
                            }
                          }
                        } catch (e) {
                          printError('$e');
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Could not connect to DB. Please try again '),
                            backgroundColor: Colors.red,
                          ));
                        }
                      })),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 160,
                      child: buildFilledButton("How to PLay?", null)),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 160,
                      child: buildFilledButton("Supabase testing", () {
                        navigateTo(SupabaseTestScreen());
                      })),
                ],
              ),
            ],
          ),
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
