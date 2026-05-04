import 'package:ai_gym_mentor/core/app_config.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/exercise_local_datasource.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/datasources/exercise_remote_datasource.dart';
import 'package:ai_gym_mentor/features/exercise_database/data/repositories/exercise_repository_impl.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/repositories/exercise_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
ExerciseRepository exerciseRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  
  final localDatasource = ExerciseLocalDatasource(db);
  final remoteDatasource = ExerciseRemoteDatasource(
    baseUrl: AppConfig.exerciseApiBaseUrl,
  );
  
  return ExerciseRepositoryImpl(
    localDatasource: localDatasource,
    remoteDatasource: remoteDatasource,
  );
}
