import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/test_provider.dart';

class TestScreen extends ConsumerWidget {
  TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("RENDER");

    var instance = ref.watch(testStateProvider);
    return WillPopScope(
      onWillPop: () async {
        ref.read(testStateProvider.notifier).closeStreamTest();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("GameScreen"),
          ),
          body: SafeArea(child: Text(instance.test.toString()))),
    );
  }
}
