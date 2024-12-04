import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:riverpod/riverpod.dart';

import '../services/username_service.dart';

final futureUuid = FutureProvider<String?>((ref) async {
  return await getUUID();
});

final futureUsername = FutureProvider<String?>((ref) async {
  return await getUsername();
});