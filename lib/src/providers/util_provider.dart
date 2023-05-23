import 'package:replaceAppName/src/services/uuid_service.dart';
import 'package:riverpod/riverpod.dart';

final futureUuid = FutureProvider<String?>((ref) async {
  return await getUUID();
});
