import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_provider.dart';
import '../database/daos/bodymap_dao.dart';

final bodyMapDaoProvider = Provider<BodyMapDao>((ref) {
  return BodyMapDao(ref.watch(appDatabaseProvider));
});
