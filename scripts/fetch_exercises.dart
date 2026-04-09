import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Script to fetch, aggregate, and normalize exercise data from multiple sources.
/// Sources:
/// 1. yuhonas/free-exercise-db
/// 2. wrkout/exercises.json
/// 3. exercisedb-api (Mirror/Public)

const String yuhonasUrl =
    'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json';
const String wrkoutApiUrl =
    'https://api.github.com/repos/wrkout/exercises.json/contents/exercises';
const String wrkoutBaseRawUrl =
    'https://raw.githubusercontent.com/wrkout/exercises.json/master/exercises';
const String exerciseDbMirrorUrl =
    'https://raw.githubusercontent.com/ExerciseDB/exercisedb-api/main/db.json'; // Estimated location

Future<void> main() async {
  print('--- Starting Exercise Data Aggregation ---');

  final List<dynamic> allExercises = [];

  // 1. Fetch from yuhonas/free-exercise-db
  print('Fetching from yuhonas/free-exercise-db...');
  try {
    final response = await http.get(Uri.parse(yuhonasUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      for (var item in data) {
        allExercises.add(normalizeYuhonas(item));
      }
      print('  - Loaded ${data.length} exercises');
    }
  } catch (e) {
    print('  - Error fetching yuhonas: $e');
  }

  // 2. Fetch from wrkout/exercises.json
  print('Fetching from wrkout/exercises.json...');
  try {
    final listResponse = await http.get(Uri.parse(wrkoutApiUrl));
    if (listResponse.statusCode == 200) {
      final List<dynamic> folders = json.decode(listResponse.body);
      print(
          '  - Found ${folders.length} folders. Fetching data.json with concurrency...');

      const batchSize = 100;
      int processed = 0;

      for (var i = 0; i < folders.length; i += batchSize) {
        final end =
            (i + batchSize < folders.length) ? i + batchSize : folders.length;
        final batch = folders.sublist(i, end);

        final results = await Future.wait(batch.map((folder) async {
          final name = folder['name'];
          final dataUrl = '$wrkoutBaseRawUrl/$name/exercise.json';
          try {
            final res = await http.get(Uri.parse(dataUrl));
            if (res.statusCode == 200) {
              return {'data': json.decode(res.body), 'name': name};
            }
          } catch (_) {}
          return null;
        }));

        for (var res in results) {
          if (res != null) {
            allExercises.add(normalizeWrkout(res['data'], res['name']));
            processed++;
          }
        }
        print('    - Processed $end folders...');
      }
      print('  - Loaded $processed exercises from $wrkoutBaseRawUrl');
    }
  } catch (e) {
    print('  - Error fetching wrkout: $e');
  }

  // 3. Fetch from ExerciseDB Mirror
  print('Fetching from ExerciseDB mirror...');
  try {
    // Check multiple possible locations for ExerciseDB mirror
    final urls = [
      'https://raw.githubusercontent.com/adrianhajdin/project_fitness_app/main/src/utils/exercises.json',
      'https://raw.githubusercontent.com/ExerciseDB/exercisedb-api/main/exercises.json',
      'https://raw.githubusercontent.com/ExerciseDB/exercisedb-api/main/db.json'
    ];

    for (var url in urls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        for (var item in data) {
          allExercises.add(normalizeExerciseDb(item));
        }
        print('  - Loaded ${data.length} exercises from $url');
        break;
      }
    }
  } catch (e) {
    print('  - Error fetching ExerciseDB: $e');
  }

  print(
      '--- Aggregation Complete. Total raw exercises: ${allExercises.length} ---');

  // 4. Deduplicate
  print('Deduplicating exercises...');
  final Map<String, dynamic> uniqueExercises = {};
  for (var ex in allExercises) {
    final nameKey = ex['name'].toString().toLowerCase().trim();
    if (!uniqueExercises.containsKey(nameKey)) {
      uniqueExercises[nameKey] = ex;
    } else {
      // Preference logic: keep if current has gifUrl and existing doesn't
      final existing = uniqueExercises[nameKey];
      if ((ex['gifUrl'] != null && existing['gifUrl'] == null) ||
          (ex['instructions'].length > existing['instructions'].length)) {
        uniqueExercises[nameKey] = ex;
      }
    }
  }

  final finalData = uniqueExercises.values.toList();
  print(
      '--- Deduplication Complete. Total unique exercises: ${finalData.length} ---');

  // 5. Save to File
  final outputFile = File('assets/data/exercises.json');
  await outputFile.parent.create(recursive: true);
  await outputFile.writeAsString(json.encode(finalData));
  print('Saved merged data to ${outputFile.path}');

  print('--- All Done ---');
}

Map<String, dynamic> normalizeYuhonas(Map<String, dynamic> item) {
  final id = item['id'] ?? '';
  return {
    'id': 'yuhonas_$id',
    'name': item['name'] ?? '',
    'description': '',
    'category': item['force'] == 'static' ? 'Stretching' : 'Strength',
    'difficulty': item['level'] ?? 'Beginner',
    'primaryMuscles': item['primaryMuscles'] ?? [],
    'secondaryMuscles': item['secondaryMuscles'] ?? [],
    'equipment': item['equipment'] ?? 'None',
    'instructions': item['instructions'] ?? [],
    'gifUrl': null, // yuhonas has images at dist/exercises/{id}/0.jpg
    'imageUrl':
        'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/$id/0.jpg',
    'videoUrl': null,
    'mechanic': item['mechanic'] ?? 'Compound',
    'force': item['force'] ?? 'Push',
    'source': 'yuhonas/free-exercise-db',
  };
}

Map<String, dynamic> normalizeWrkout(
    Map<String, dynamic> item, String folderName) {
  return {
    'id': 'wrkout_${item['id'] ?? folderName}',
    'name': item['name'] ?? folderName.replaceAll('_', ' '),
    'description': '',
    'category': 'Strength',
    'difficulty': 'Intermediate',
    'primaryMuscles': [], // wrkout structure varies, often in secondary or tags
    'secondaryMuscles': [],
    'equipment': item['equipment'] ?? 'None',
    'instructions': item['instructions'] ?? [],
    'gifUrl': null,
    'imageUrl': null,
    'videoUrl': null,
    'mechanic': 'Compound',
    'force': 'Push',
    'source': 'wrkout/exercises.json',
  };
}

Map<String, dynamic> normalizeExerciseDb(Map<String, dynamic> item) {
  return {
    'id': item['id'] ?? '',
    'name': item['name'] ?? '',
    'description': '',
    'category': item['bodyPart'] ?? 'Strength',
    'difficulty': 'Intermediate',
    'primaryMuscles': [item['target'] ?? ''],
    'secondaryMuscles': item['secondaryMuscles'] ?? [],
    'equipment': item['equipment'] ?? 'None',
    'instructions': item['instructions'] ?? [],
    'gifUrl': item['gifUrl'],
    'imageUrl': null,
    'videoUrl': null,
    'mechanic': 'Compound',
    'force': 'Push',
    'source': 'ExerciseDB',
  };
}
