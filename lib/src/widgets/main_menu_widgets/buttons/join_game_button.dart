import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/services/database_service.dart';

import '../../../providers/game_provider.dart';
import '../../../providers/uuid_provider.dart';
import '../../../screens/game_screen_provider.dart';
import '../../../screens/game_sreen.dart';
import '../../../utils/helpers.dart';
import '../../show_snackbar.dart';

class JoinGameButton extends ConsumerWidget {
  const JoinGameButton({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureValue = ref.watch(futureUuid);
    GameState gameState = ref.watch(gameStateProvider);

    return futureValue.when(
        data: (data) => SizedBox(
            width: 160,
            child: SizedBox(
                width: 160,
                child: FilledButton(
                    onPressed: () async {
                      try {
                        var roomId = await db.joinRoom();
                        printGreen('JOINED_ROOM: $roomId, I AM BLACK');
                        if (context.mounted) {
                          ref.read(gameStateProvider.notifier).setState(roomId, 'black');
                          printGreen('STATE JOINED_ROOM: ${gameState.gameIdInDB}');
                          navigateTo(context, GameScreenTest());
                        }
                      } catch (e) {
                        printError(e.toString());
                        showError(
                            currentContext: context,
                            message: e.toString(),
                            isError: true);
                      }
                    },
                    child: const Text('Join Game')))),
        error: (e, st) => Center(child: Text(e.toString())),
        loading: () => Container());
  }
}
