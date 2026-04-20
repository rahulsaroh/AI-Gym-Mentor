import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:ai_gym_mentor/features/settings/settings_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

part 'gemini_service.g.dart';

@riverpod
class GeminiService extends _$GeminiService {
  late GenerativeModel _model;

  @override
  void build() {
    // GenerativeModel will be re-initialized on demand using current settings in methods
  }

  GenerativeModel _getModel() {
    final settings = ref.read(settingsProvider).value;
    final apiKey = settings?.geminiApiKey ?? dotenv.env['GEMINI_API_KEY'] ?? '';
    
    return GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
    );
  }

  String _extractJson(String text) {
    // Robust extraction: find start/end of array or object
    final jsonMatch = RegExp(r'(\[[\s\S]*\]|\{[\s\S]*\})').firstMatch(text);
    if (jsonMatch != null) {
      return jsonMatch.group(1)!.trim();
    }
    
    // Fallback: existing markdown cleaning
    return text.contains('```') 
        ? text.split('```')[1].replaceAll('json', '').trim() 
        : text.trim();
  }

  Future<Map<String, dynamic>> enrichExercise(ExerciseEntity exercise) async {
    final prompt = '''
    Act as a professional kinesiologist and fitness expert. 
    Enrich the following exercise details with scientific accuracy and safety cues.
    
    Exercise: ${exercise.name}
    Current Equipment: ${exercise.equipment}
    Target Muscles: ${exercise.primaryMuscles.join(', ')}
    
    Provide the response in EXPLICIT JSON format with these exact keys:
    {
      "safety_tips": ["tip 1", "tip 2", ...],
      "common_mistakes": ["mistake 1", "mistake 2", ...],
      "overview": "A concise 2-3 sentence overview of why this exercise is effective and what it targets.",
      "variations": ["variation name 1", "variation name 2"],
      "instructions_hindi": ["step 1 in Hindi", "step 2 in Hindi"],
      "name_hindi": "Hindi name",
      "name_marathi": "Marathi name"
    }
    
    Ensure instructions and safety tips are clear, actionable, and focus on spinal neutrality and joint safety.
    ''';

    try {
      final model = _getModel();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      final text = response.text;
      if (text == null) throw Exception('Empty response from AI');
      
      final jsonStr = _extractJson(text);
      return jsonDecode(jsonStr);
    } catch (e) {
      if (e.toString().contains('401') || e.toString().contains('403')) {
        throw Exception('Invalid or missing Gemini API Key. Please check your AI settings.');
      }
      throw Exception('AI Enrichment failed: $e');
    }
  }

  Future<String> getCoachCue(String exerciseName, List<Map<String, dynamic>> context) async {
    final prompt = '''
    Act as a high-performance strength coach. Give a 10-15 word punchy technical cue or motivational advice for the following exercise:
    
    Exercise: $exerciseName
    Recent Sets: ${context.toString()}
    
    If they are hitting their reps, motivate them. If they missed reps, give a technical tip (e.g., 'Drive through heels' or 'Keep elbows tucked'). 
    NO fluff. Just the cue.
    ''';

    try {
      final model = _getModel();
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? "Focus on form and drive!";
    } catch (e) {
      return "Keep pushing! Focus on the contraction.";
    }
  }
  Future<List<Map<String, dynamic>>> generateWorkoutPlan({
    required List<String> bodyParts,
    required String equipmentPreference,
    required int durationMinutes,
  }) async {
    final prompt = '''
    Act as a professional strength and conditioning coach. 
    Generate a high-intensity, effective workout plan based on these parameters:
    
    Target Body Parts: ${bodyParts.join(', ')}
    Equipment Available: $equipmentPreference
    Total Duration: $durationMinutes minutes
    
    Provide exactly ${ (durationMinutes / 10).round().clamp(3, 8) } exercises in a structured JSON list.
    
    Response MUST be EXPLICIT JSON with this structure:
    [
      {
        "exercise_name": "Standard Name of Exercise",
        "sets": 3,
        "reps": "10-12",
        "target_muscle": "Primary Muscle Group"
      }
    ]
    
    Constraints:
    1. Use canonical exercise names (e.g., 'Incline Barbell Bench Press' instead of 'incline chest press').
    2. Exercises must be compatible with $equipmentPreference.
    3. Ensure a logical progression (e.g., compound movements before isolation).
    4. Match the variety to the $durationMinutes minutes duration.
    ''';

    try {
      final model = _getModel();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      final text = response.text;
      if (text == null) throw Exception('Empty response from AI');
      
      final jsonStr = _extractJson(text);
          
      final List<dynamic> decoded = jsonDecode(jsonStr);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      if (e.toString().contains('401') || e.toString().contains('403')) {
        throw Exception('Invalid or missing Gemini API Key. Go to Settings > AI Configuration.');
      }
      throw Exception('Workout Generation failed: $e');
    }
  }
}

