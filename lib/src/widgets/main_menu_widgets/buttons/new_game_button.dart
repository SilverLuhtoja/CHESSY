import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/screens/game_screen_provider.dart';
import '../../../providers/uuid_provider.dart';
import '../../../utils/helpers.dart';
import '../../show_snackbar.dart';

class NewGameButton extends ConsumerWidget {
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureValue = ref.watch(futureUuid);

    return futureValue.when(
        data: (data) => SizedBox(
            width: 160,
            child: SizedBox(
                width: 160,
                child: FilledButton(
                    onPressed: () async {
                      try {
                        // await db.createNewGame();
                        printGreen("DB: new game created");
                        if (context.mounted) navigateTo(context, GameScreenTest());
                      } catch (e) {
                        printError(e.toString());
                        showError(
                            currentContext: context,
                            message: 'Could not connect to DB. Please try again ',
                            isError: true);
                      }
                    },
                    child: const Text('New Game')))),
        error: (e, st) => Center(child: Text(e.toString())),
        loading: () => Container());
  }
}
