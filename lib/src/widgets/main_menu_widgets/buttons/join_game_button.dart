import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/game_provider.dart';
import '../../../providers/uuid_provider.dart';
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
      child: FilledButton(
          onPressed: () async {
            try {
              String myColor = await db.joinRoom();
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
          },
          child: const Text('Join Game')),
    );
  }
}
