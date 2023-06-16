import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/game_provider.dart';
import '../../../screens/game_screen.dart';
import '../../../services/database_service.dart';
import '../../../utils/helpers.dart';
import '../../show_snackbar.dart';

class JoinGameButton extends ConsumerWidget {
  const JoinGameButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gamePiecesStateProvider.notifier);

    return SizedBox(
      width: 160,
      child: FutureBuilder(
          future: db.getAvailableRooms(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data?.isEmpty == true
                  ? disabledButton()
                  : FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AvailableRooms(data: snapshot.data)),
                        );
                      },
                      child: const Text('Join Game'));
            } else {
              return disabledButton();
            }
          }),
    );
  }

  FilledButton disabledButton() =>
      const FilledButton(onPressed: null, child: Text('Join Game'));
}

class AvailableRooms extends ConsumerWidget {
  final List<dynamic>? data;

  AvailableRooms({
    super.key,
    required this.data,
  });

  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(gamePiecesStateProvider.notifier);

    joinGame(int id) async {
      try {
        String myColor = await db.joinRoom(id);
        provider.setMyColor(myColor);
        if (context.mounted) {
          provider.startStream();
          navigateTo(context, GameScreen());
          printGreen("join_game_button: joined with room > ${db.id}");
        }
      } catch (e) {
        printError(e.toString());
        showError(
            currentContext: context,
            message: 'Could not connect to DB. Please try again ',
            isError: true);
      }
    }

    _getRooms() async {
      return await db.getAvailableRooms();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('JOIN GAME'),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Text('AVAILABLE ROOMS TO JOIN:'),
            FutureBuilder(
                future: _getRooms(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Game created by: ${snapshot.data![index]['creator_name']}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      joinGame(
                                          snapshot.data![index]['game_id']);
                                    },
                                    color: Colors.blue,
                                    minWidth: 0,
                                    height: 20,
                                    child: Text(
                                      'JOIN',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return Text('No rooms available.');
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ));
  }
}
