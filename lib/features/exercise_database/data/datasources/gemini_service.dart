import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ai_gym_mentor/features/exercise_database/domain/entities/exercise_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'gemini_service.g.dart';

@riverpod
class GeminiService extends _$GeminiService {
  late GenerativeModel _model;

  @override
  void build() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
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
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final text = response.text;
      if (text == null) throw Exception('Empty response from AI');
      
      // Clean up JSON if AI adds markdown backticks
      final jsonStr = text.contains('```') 
          ? text.split('```json')[1].split('```')[0].trim() 
          : text.trim();
          
      return jsonDecode(jsonStr);
    } catch (e) {
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
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text?.trim() ?? "Focus on form and drive!";
    } catch (e) {
      return "Keep pushing! Focus on the contraction.";
    }
  }
}
