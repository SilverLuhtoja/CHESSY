import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/screens/game_screen.dart';
import '../../../providers/game_provider.dart';
import '../../../services/database_service.dart';
import '../../../utils/helpers.dart';
import '../../show_snackbar.dart';

class NewGameButton extends ConsumerWidget {
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameProvider = ref.read(gamePiecesStateProvider.notifier);

    return SizedBox(
      width: 160,
      child: FilledButton(
          onPressed: () async {
            try {
              String myColor = await db.createNewGame();
              gameProvider.setMyColor(myColor);
              printGreen("new_game_button: new game created");
              if (context.mounted) {
                gameProvider.startStream();
                navigateTo(context, GameScreen());
                // ref.read(testStateProvider.notifier).startStreamTest();
                // navigateTo(context, TestScreen());
              }
            } catch (e) {
              printError(e.toString());
              showError(
                  currentContext: context,
                  message: 'Could not connect to DB. Please try again ',
                  isError: true);
            }
          },
          child: const Text('New Game')),
    );
  }
}
