import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';

class TestState {
  String? test;

  TestState({required this.test});
}

class TestStateNotifier extends StateNotifier<TestState> {
  TestStateNotifier() : super(TestState(test: 'Start'));

  late StreamSubscription<dynamic> _stream;

  updateState([String? value]) {
    state.test = value;
  }

  startStreamTest() {
    _stream = db.createStream().listen((event) {
      printWarning(event.toString());
      dynamic json = event[0];

      if (json['current_turn'].toString().isEmpty) {
        printError('is null');
      } else {
        print(json['current_turn']);
        state = TestState(test: json['current_turn']);
      }
    });
  }

  closeStreamTest() {
    _stream.cancel();
  }
}

final testStateProvider = StateNotifierProvider<TestStateNotifier, TestState>((ref) {
  return TestStateNotifier();
});
