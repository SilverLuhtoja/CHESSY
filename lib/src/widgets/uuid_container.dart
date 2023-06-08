import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replaceAppName/src/providers/util_provider.dart';

class UuidContainer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureValue = ref.watch(futureUuid);

    return futureValue.when(
        data: (data) => Container(
            margin: EdgeInsets.only(bottom: 50),
            child: data == null ? Text("NO UUID") : Text(data)),
        error: (e, st) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}