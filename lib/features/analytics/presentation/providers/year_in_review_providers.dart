import 'package:ai_gym_mentor/features/analytics/data/year_in_review_service.dart';
import 'package:ai_gym_mentor/features/analytics/domain/year_in_review_models.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'year_in_review_providers.g.dart';

@riverpod
class YearInReviewNotifier extends _$YearInReviewNotifier {
  @override
  Future<YearInReviewData?> build(int year) async {
    final service = ref.watch(yearInReviewServiceProvider);
    final settings = await ref.watch(settingsProvider.future);
    
    return await service.computeYearInReview(year, settings.oneRmFormula);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(yearInReviewServiceProvider);
      final settings = await ref.read(settingsProvider.future);
      return await service.computeYearInReview(year, settings.oneRmFormula);
    });
  }
}

@riverpod
Future<List<int>> availableReviewYears(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  // Get unique years from workouts
  final query = db.selectOnly(db.workouts)
    ..addColumns([db.workouts.date])
    ..where(db.workouts.status.equals('completed'))
    ..orderBy([OrderingTerm.desc(db.workouts.date)]);
    
  final rows = await query.get();
  final years = rows.map((r) => r.read(db.workouts.date)?.year).whereType<int>().toSet().toList();
  years.sort((a, b) => b.compareTo(a));
  return years;
}
