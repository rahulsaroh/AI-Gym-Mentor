import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {
  print('--- AI Gym Mentor: Exercise Enrichment Tool ---');

  // 1. Load API Key (Manual parsing to avoid Flutter dependency)
  String? apiKey;
  final envFile = File('.env');
  if (await envFile.exists()) {
    final lines = await envFile.readAsLines();
    for (var line in lines) {
      if (line.startsWith('GEMINI_API_KEY=')) {
        apiKey = line.split('=')[1].replaceAll('"', '').trim();
      }
    }
  }
  
  final bool isMockMode = apiKey == null || apiKey == 'test_key' || apiKey.isEmpty;

  if (isMockMode) {
    print('NOTICE: No valid API key found. Running in MOCK MODE for verification.');
  }

  // 2. Initialize Gemini
  GenerativeModel? model;
  if (!isMockMode) {
    model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }
  
  // 3. Load Local Exercises
  final localFile = File('assets/data/exercises.json');
  if (!await localFile.exists()) {
    print('Error: assets/data/exercises.json not found!');
    return;
  }
  
  final List<dynamic> localExercises = json.decode(await localFile.readAsString());
  print('Loaded ${localExercises.length} local exercises.');

  // 4. Filter for unenriched exercises (limit to session batch size)
  final sessionLimit = 10;
  final targets = localExercises.where((e) => e['isEnriched'] != true).take(sessionLimit).toList();
  
  if (targets.isEmpty) {
    print('All exercises are already enriched!');
    return;
  }

  print('Processing $sessionLimit exercises in this batch...');

  for (var ex in targets) {
    final name = ex['name'];
    print('Enriching: $name...');

    final prompt = '''
    As a professional fitness coach, provide detailed enrichment for the exercise: "$name".
    Return the response strictly as a JSON object with the following keys:
    - "safetyTips": [List of 3-4 specific safety precautions]
    - "commonMistakes": [List of 3-4 frequent form errors]
    - "nameHi": "Hindi name or transliteration"
    - "nameMr": "Marathi name or transliteration"
    - "overview": "A concise 2-sentence description of the exercise and its primary benefit."
    - "mechanic": "compound" or "isolation"
    
    Instructions for this exercise: ${ex['instructions'] ?? 'N/A'}
    ''';

    try {
      Map<String, dynamic> jsonResponse;

      if (isMockMode) {
        jsonResponse = {
          'safetyTips': ['Maintain a neutral spine during the movement.', 'Exhale on the exertion phase.', 'Avoid using excessive momentum.'],
          'commonMistakes': ['Arching the back too much.', 'Rushing the repetitions.', 'Incomplete range of motion.'],
          'nameHi': '$name (अनुकूलित)',
          'nameMr': '$name (मराठीत)',
          'overview': 'A highly effective exercise for building strength and stability in the target muscle groups.',
          'mechanic': 'compound'
        };
        await Future.delayed(const Duration(milliseconds: 500));
      } else {
        final content = [Content.text(prompt)];
        final response = await model!.generateContent(content);
        jsonResponse = _extractJson(response.text ?? '{}');
      }

      // Update the exercise entry
      ex['safetyTips'] = jsonResponse['safetyTips'] ?? [];
      ex['commonMistakes'] = jsonResponse['commonMistakes'] ?? [];
      ex['nameHi'] = jsonResponse['nameHi'] ?? '';
      ex['nameMr'] = jsonResponse['nameMr'] ?? '';
      ex['overview'] = jsonResponse['overview'] ?? '';
      ex['mechanic'] = jsonResponse['mechanic'] ?? 'compound';
      ex['isEnriched'] = true;

      print('  Done: enriched $name');
      
      // Artificial delay to prevent rate limits
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      print('  Failed to enrich $name: $e');
    }
  }

  // 5. Save Results
  await localFile.writeAsString(const JsonEncoder.withIndent('  ').convert(localExercises));
  print('Batch enrichment complete! Updated assets/data/exercises.json');
}

Map<String, dynamic> _extractJson(String text) {
  try {
    // Attempt to extract JSON from markdown code blocks if present
    final regex = RegExp(r'\{.*\}', dotAll: true);
    final match = regex.firstMatch(text);
    if (match != null) {
      return json.decode(match.group(0)!);
    }
    return json.decode(text);
  } catch (e) {
    print('JSON Extraction error: $e');
    return {};
  }
}
