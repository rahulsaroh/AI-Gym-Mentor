import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_service.g.dart';

@Riverpod(keepAlive: true)
AiService aiService(Ref ref) {
  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  return AiService(apiKey);
}

class AiService {
  final String _apiKey;
  late final GenerativeModel _model;

  AiService(this._apiKey) {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);
  }

  Future<String> generatePhaseChangeMessage({
    required String userName,
    required int previousPhase,
    required int nextPhase,
    required String context,
  }) async {
    if (_apiKey.isEmpty) {
      return "Great job crushing the first phase! We've updated your routine to Phase $nextPhase. Let's break that plateau!";
    }

    final prompt = '''
You are the AI Gym Mentor. The user, $userName, has just completed Phase $previousPhase of their workout program.
They are now transitioning to Phase $nextPhase.

Here is some context about their recent performance:
$context

Generate a highly personalized, dynamic, and encouraging message (max 3 sentences) to congratulate them and motivate them for the next phase.
Focus on their consistency and the shift in training intensity.
''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? "Great job! Phase $nextPhase starts now.";
    } catch (e) {
      return "Great job! We've moved you to Phase $nextPhase based on your progress.";
    }
  }
}
